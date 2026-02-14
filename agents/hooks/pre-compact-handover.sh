#!/bin/bash
set -euo pipefail

INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path')
CWD=$(echo "$INPUT" | jq -r '.cwd')
TRIGGER=$(echo "$INPUT" | jq -r '.trigger')
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id')

MEMORY_DIR="$HOME/.claude/projects/$(echo "$CWD" | tr '/' '-')/memory"
mkdir -p "$MEMORY_DIR"
HANDOVER_FILE="$MEMORY_DIR/HANDOVER.md"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

GIT_BRANCH=$(cd "$CWD" && git branch --show-current 2>/dev/null || echo "unknown")
GIT_STATUS=$(cd "$CWD" && git status --short 2>/dev/null | head -30 || echo "clean")
GIT_DIFF_STAT=$(cd "$CWD" && git diff --stat 2>/dev/null | tail -20 || echo "")

TAIL_LINES=500
TRANSCRIPT_TAIL=$(tail -"$TAIL_LINES" "$TRANSCRIPT_PATH" 2>/dev/null || echo "")

USER_MESSAGES=$(echo "$TRANSCRIPT_TAIL" | jq -r '
  select(.type == "user" and .isMeta != true) |
  select(.message.content | type == "string") |
  select(.message.content | test("^<(command-name|local-command|system-reminder)") | not) |
  .message.content' 2>/dev/null | tail -c 4000 || echo "")

ASSISTANT_TEXT=$(echo "$TRANSCRIPT_TAIL" | jq -r '
  select(.type == "assistant") |
  [.message.content[] | select(.type == "text") | .text] |
  join("\n")' 2>/dev/null | tail -c 4000 || echo "")

FILE_OPS=$(echo "$TRANSCRIPT_TAIL" | jq -r '
  select(.type == "assistant") |
  .message.content[] |
  select(.type == "tool_use") |
  select(.name == "Edit" or .name == "Write") |
  "\(.name): \(.input.file_path)"' 2>/dev/null | sort -u | tail -30 || echo "")

FILES_READ=$(echo "$TRANSCRIPT_TAIL" | jq -r '
  select(.type == "assistant") |
  .message.content[] |
  select(.type == "tool_use" and .name == "Read") |
  .input.file_path' 2>/dev/null | sort -u | tail -20 || echo "")

BASH_CMDS=$(echo "$TRANSCRIPT_TAIL" | jq -r '
  select(.type == "assistant") |
  .message.content[] |
  select(.type == "tool_use" and .name == "Bash") |
  .input.command' 2>/dev/null | tail -c 2000 || echo "")

{
  echo "# Handover Context (Pre-Compaction)"
  echo "Generated: $TIMESTAMP"
  echo "Trigger: $TRIGGER | Session: $SESSION_ID"
  echo ""
  echo "## Git State"
  echo "Branch: \`$GIT_BRANCH\`"
  echo ""
  if [ -n "$GIT_STATUS" ]; then
    echo "### Working Tree"
    echo '```'
    echo "$GIT_STATUS"
    echo '```'
    echo ""
  fi
  if [ -n "$GIT_DIFF_STAT" ]; then
    echo "### Diff Summary"
    echo '```'
    echo "$GIT_DIFF_STAT"
    echo '```'
    echo ""
  fi
  echo "## User Prompts"
  if [ -n "$USER_MESSAGES" ]; then
    echo "$USER_MESSAGES"
  else
    echo "(none captured)"
  fi
  echo ""
  echo "## Assistant Context"
  if [ -n "$ASSISTANT_TEXT" ]; then
    echo "$ASSISTANT_TEXT"
  else
    echo "(none captured)"
  fi
  echo ""
  echo "## Files Modified (Edit/Write)"
  if [ -n "$FILE_OPS" ]; then
    echo '```'
    echo "$FILE_OPS"
    echo '```'
  else
    echo "(none)"
  fi
  echo ""
  echo "## Files Read"
  if [ -n "$FILES_READ" ]; then
    echo '```'
    echo "$FILES_READ"
    echo '```'
  else
    echo "(none)"
  fi
  echo ""
  echo "## Commands Run"
  if [ -n "$BASH_CMDS" ]; then
    echo '```bash'
    echo "$BASH_CMDS"
    echo '```'
  else
    echo "(none)"
  fi
} > "$HANDOVER_FILE"

echo '{"systemMessage": "Handover document saved to '"$HANDOVER_FILE"'"}'
exit 0
