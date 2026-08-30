#!/bin/bash
# MemPalace background-mine hook (owned) — efficient, non-blocking auto-save.
#
# Replaces the mempalace plugin's blocking Stop/PreCompact hooks. Mines the
# session transcript into the palace as a detached background process, then
# always emits valid empty JSON ({}) so the event is never blocked and never
# produces a schema-validation error.
#
#   stop       — mine every $SAVE_INTERVAL human messages
#   precompact — mine unconditionally before context is compacted
#
# Backgrounding is safe even on PreCompact: mining reads the transcript from
# disk, and compaction compresses in-context history, not the on-disk file.

MODE="${1:-stop}"
SAVE_INTERVAL=15
STATE_DIR="$HOME/.mempalace/hook_state"
LOG="$STATE_DIR/hook.log"
mkdir -p "$STATE_DIR"

emit() { echo '{}'; exit 0; }

INPUT=$(cat)

PARSED=$(printf '%s' "$INPUT" | python3 -c '
import sys, json, re
d = json.load(sys.stdin)
sid = re.sub(r"[^A-Za-z0-9_-]", "", str(d.get("session_id", "unknown"))) or "unknown"
sha = "1" if str(d.get("stop_hook_active", False)).lower() in ("true", "1", "yes") else "0"
tp  = re.sub(r"[^A-Za-z0-9_./~ -]", "", str(d.get("transcript_path", "")))
print(f"{sid}\t{sha}\t{tp}")
' 2>/dev/null)

SESSION_ID=$(printf '%s' "$PARSED" | cut -f1)
STOP_ACTIVE=$(printf '%s' "$PARSED" | cut -f2)
TRANSCRIPT_PATH=$(printf '%s' "$PARSED" | cut -f3)
TRANSCRIPT_PATH="${TRANSCRIPT_PATH/#\~/$HOME}"

# Post-save Stop re-entry: nothing to do.
[ "$STOP_ACTIVE" = "1" ] && emit
# No transcript on disk: nothing to mine.
{ [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; } || emit

mine() {
  # convos mode: the target is a transcript dir. Default 'projects' mode skips
  # .jsonl entirely and requires a mempalace.yaml we don't want to maintain.
  nohup python3 -m mempalace mine "$(dirname "$TRANSCRIPT_PATH")" --mode convos >> "$LOG" 2>&1 </dev/null &
}

if [ "$MODE" = "precompact" ]; then
  printf '[%s] precompact mine for %s\n' "$(date '+%H:%M:%S')" "$SESSION_ID" >> "$LOG"
  mine
  emit
fi

# Stop mode: only mine once every $SAVE_INTERVAL human messages.
COUNT=$(python3 - "$TRANSCRIPT_PATH" <<'PY' 2>/dev/null
import sys, json
n = 0
with open(sys.argv[1], encoding="utf-8", errors="replace") as f:
    for line in f:
        try:
            m = json.loads(line).get("message", {})
        except Exception:
            continue
        if isinstance(m, dict) and m.get("role") == "user":
            c = m.get("content", "")
            if isinstance(c, str) and "<command-message>" in c:
                continue
            n += 1
print(n)
PY
)
[ -n "$COUNT" ] || COUNT=0

LAST_FILE="$STATE_DIR/${SESSION_ID}_last_save"
LAST=0
if [ -f "$LAST_FILE" ]; then
  RAW=$(cat "$LAST_FILE")
  [[ "$RAW" =~ ^[0-9]+$ ]] && LAST="$RAW"
fi

if [ "$COUNT" -gt 0 ] && [ "$((COUNT - LAST))" -ge "$SAVE_INTERVAL" ]; then
  printf '%s' "$COUNT" > "$LAST_FILE"
  printf '[%s] stop mine at %s msgs for %s\n' "$(date '+%H:%M:%S')" "$COUNT" "$SESSION_ID" >> "$LOG"
  mine
fi

emit
