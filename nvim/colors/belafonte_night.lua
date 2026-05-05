-- Belafonte Night -- the dark sibling of Belafonte Day.
-- Same 16-color ANSI palette, with bg/fg swapped to the deep aubergine + cream.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.background = "dark"
vim.g.colors_name = "belafonte_night"

local c = {
    bg          = "#20111a",
    bg_dim      = "#2a1a23",
    bg_float    = "#2f1d26",
    bg_visual   = "#5e5252",
    bg_visual_dim = "#3a2630",
    bg_cursor   = "#2c1c25",

    fg          = "#d4ccb9",
    fg_dim      = "#958b83",
    fg_subtle   = "#7a6e6c",
    fg_mute     = "#5e5252",

    black       = "#20111a",
    white       = "#d4ccb9",

    -- accents: lifted slightly where needed for contrast on the dark bg
    red         = "#d6403d",
    green       = "#a8a47e",
    yellow      = "#e9a448",
    blue        = "#7aa3b3",
    rust        = "#c47550",
    gray        = "#98999c",

    diff_add    = "#3a4a2a",
    diff_change = "#5a4a1f",
    diff_delete = "#5a2520",
    diff_text   = "#7a5a20",

    none        = "NONE",
}

local hl = vim.api.nvim_set_hl
local function set(group, opts) hl(0, group, opts) end

-- Editor UI ----------------------------------------------------------------
set("Normal",       { fg = c.fg, bg = c.bg })
set("NormalNC",     { fg = c.fg, bg = c.bg })
set("NormalFloat",  { fg = c.fg, bg = c.bg_float })
set("FloatBorder",  { fg = c.fg_mute, bg = c.bg_float })
set("FloatTitle",   { fg = c.rust, bg = c.bg_float, bold = true })
set("WinSeparator", { fg = c.fg_mute, bg = c.bg })
set("VertSplit",    { fg = c.fg_mute, bg = c.bg })

set("Cursor",       { fg = c.bg, bg = c.fg })
set("CursorLine",   { bg = c.bg_cursor })
set("CursorColumn", { bg = c.bg_cursor })
set("ColorColumn",  { bg = c.bg_dim })
set("CursorLineNr", { fg = c.rust, bold = true })
set("LineNr",       { fg = c.fg_mute })
set("SignColumn",   { bg = c.bg })
set("FoldColumn",   { fg = c.fg_mute, bg = c.bg })
set("Folded",       { fg = c.fg_subtle, bg = c.bg_dim, italic = true })

set("Visual",       { bg = c.bg_visual, fg = c.bg })
set("VisualNOS",    { bg = c.bg_visual_dim })
set("Search",       { fg = c.bg, bg = c.yellow })
set("IncSearch",    { fg = c.bg, bg = c.rust })
set("CurSearch",    { fg = c.bg, bg = c.rust })
set("MatchParen",   { fg = c.rust, bold = true, underline = true })

set("Pmenu",        { fg = c.fg, bg = c.bg_float })
set("PmenuSel",     { fg = c.bg, bg = c.blue, bold = true })
set("PmenuSbar",    { bg = c.bg_dim })
set("PmenuThumb",   { bg = c.fg_mute })

set("StatusLine",   { fg = c.fg, bg = c.bg_dim })
set("StatusLineNC", { fg = c.fg_mute, bg = c.bg_dim })
set("TabLine",      { fg = c.fg_subtle, bg = c.bg_dim })
set("TabLineSel",   { fg = c.rust, bg = c.bg, bold = true })
set("TabLineFill",  { bg = c.bg_dim })
set("WildMenu",     { fg = c.bg, bg = c.blue })

set("MsgArea",      { fg = c.fg, bg = c.bg })
set("ModeMsg",      { fg = c.rust, bold = true })
set("MoreMsg",      { fg = c.green })
set("ErrorMsg",     { fg = c.red, bold = true })
set("WarningMsg",   { fg = c.yellow, bold = true })
set("Question",     { fg = c.blue })
set("Title",        { fg = c.rust, bold = true })
set("Directory",    { fg = c.blue, bold = true })
set("NonText",      { fg = c.fg_mute })
set("Whitespace",   { fg = c.fg_mute })
set("SpecialKey",   { fg = c.fg_mute })
set("Conceal",      { fg = c.fg_mute })
set("EndOfBuffer",  { fg = c.bg })

-- Spell ---------------------------------------------------------------------
set("SpellBad",   { sp = c.red,    undercurl = true })
set("SpellCap",   { sp = c.blue,   undercurl = true })
set("SpellLocal", { sp = c.green,  undercurl = true })
set("SpellRare",  { sp = c.rust,   undercurl = true })

-- Diff ----------------------------------------------------------------------
set("DiffAdd",    { bg = c.diff_add })
set("DiffChange", { bg = c.diff_change })
set("DiffDelete", { bg = c.diff_delete, fg = c.fg_dim })
set("DiffText",   { bg = c.diff_text, bold = true })

-- Syntax (legacy) -----------------------------------------------------------
set("Comment",      { fg = c.fg_mute, italic = true })

set("Constant",     { fg = c.yellow })
set("String",       { fg = c.green })
set("Character",    { fg = c.green })
set("Number",       { fg = c.yellow })
set("Boolean",      { fg = c.yellow })
set("Float",        { fg = c.yellow })

set("Identifier",   { fg = c.fg })
set("Function",     { fg = c.blue })

set("Statement",    { fg = c.rust, bold = true })
set("Conditional",  { fg = c.rust, bold = true })
set("Repeat",       { fg = c.rust, bold = true })
set("Label",        { fg = c.rust })
set("Operator",     { fg = c.fg_dim })
set("Keyword",      { fg = c.rust, bold = true })
set("Exception",    { fg = c.red, bold = true })

set("PreProc",      { fg = c.yellow })
set("Include",      { fg = c.rust })
set("Define",       { fg = c.rust })
set("Macro",        { fg = c.rust })
set("PreCondit",    { fg = c.yellow })

set("Type",         { fg = c.blue })
set("StorageClass", { fg = c.rust })
set("Structure",    { fg = c.blue })
set("Typedef",      { fg = c.blue })

set("Special",      { fg = c.rust })
set("SpecialChar",  { fg = c.rust })
set("Tag",          { fg = c.blue })
set("Delimiter",    { fg = c.fg_dim })
set("SpecialComment", { fg = c.fg_subtle, italic = true, bold = true })
set("Debug",        { fg = c.red })

set("Underlined",   { fg = c.blue, underline = true })
set("Ignore",       { fg = c.fg_mute })
set("Error",        { fg = c.red, bold = true })
set("Todo",         { fg = c.bg, bg = c.yellow, bold = true })

-- Treesitter ----------------------------------------------------------------
set("@comment",            { link = "Comment" })
set("@comment.todo",       { fg = c.bg, bg = c.yellow, bold = true })
set("@comment.note",       { fg = c.bg, bg = c.blue, bold = true })
set("@comment.warning",    { fg = c.bg, bg = c.rust, bold = true })
set("@comment.error",      { fg = c.bg, bg = c.red, bold = true })

set("@variable",           { fg = c.fg })
set("@variable.builtin",   { fg = c.rust, italic = true })
set("@variable.parameter", { fg = c.fg, italic = true })
set("@variable.member",    { fg = c.fg })

set("@constant",           { fg = c.yellow })
set("@constant.builtin",   { fg = c.yellow, italic = true })
set("@constant.macro",     { fg = c.yellow })

set("@module",             { fg = c.blue })
set("@label",              { fg = c.rust })

set("@string",             { fg = c.green })
set("@string.regexp",      { fg = c.rust })
set("@string.escape",      { fg = c.rust, bold = true })
set("@string.special",     { fg = c.rust })
set("@character",          { fg = c.green })
set("@character.special",  { fg = c.rust })

set("@number",             { fg = c.yellow })
set("@boolean",            { fg = c.yellow, italic = true })
set("@float",              { fg = c.yellow })

set("@function",           { fg = c.blue })
set("@function.builtin",   { fg = c.blue, italic = true })
set("@function.call",      { fg = c.blue })
set("@function.macro",     { fg = c.rust })
set("@function.method",    { fg = c.blue })
set("@function.method.call", { fg = c.blue })
set("@constructor",        { fg = c.blue, bold = true })

set("@operator",           { fg = c.fg_dim })

set("@keyword",            { fg = c.rust, bold = true })
set("@keyword.function",   { fg = c.rust, bold = true })
set("@keyword.operator",   { fg = c.rust })
set("@keyword.import",     { fg = c.rust })
set("@keyword.return",     { fg = c.rust, bold = true })
set("@keyword.exception",  { fg = c.red, bold = true })
set("@keyword.conditional", { fg = c.rust, bold = true })
set("@keyword.repeat",     { fg = c.rust, bold = true })

set("@punctuation.delimiter", { fg = c.fg_dim })
set("@punctuation.bracket",   { fg = c.fg_dim })
set("@punctuation.special",   { fg = c.rust })

set("@type",               { fg = c.blue })
set("@type.builtin",       { fg = c.blue, italic = true })
set("@type.definition",    { fg = c.blue })
set("@attribute",          { fg = c.yellow })
set("@property",           { fg = c.fg })

set("@tag",                { fg = c.rust, bold = true })
set("@tag.attribute",      { fg = c.yellow })
set("@tag.delimiter",      { fg = c.fg_dim })

-- Markup
set("@markup.heading",       { fg = c.rust, bold = true })
set("@markup.heading.1",     { fg = c.red,  bold = true })
set("@markup.heading.2",     { fg = c.rust, bold = true })
set("@markup.heading.3",     { fg = c.yellow, bold = true })
set("@markup.heading.4",     { fg = c.green, bold = true })
set("@markup.heading.5",     { fg = c.blue, bold = true })
set("@markup.heading.6",     { fg = c.fg_dim, bold = true })
set("@markup.strong",        { bold = true })
set("@markup.italic",        { italic = true })
set("@markup.strikethrough", { strikethrough = true })
set("@markup.underline",     { underline = true })
set("@markup.quote",         { fg = c.fg_subtle, italic = true })
set("@markup.math",          { fg = c.yellow })
set("@markup.link",          { fg = c.blue, underline = true })
set("@markup.link.label",    { fg = c.blue })
set("@markup.link.url",      { fg = c.blue, underline = true })
set("@markup.raw",           { fg = c.green })
set("@markup.raw.block",     { fg = c.green })
set("@markup.list",          { fg = c.rust })

-- Diff treesitter
set("@diff.plus",  { fg = c.green })
set("@diff.minus", { fg = c.red })
set("@diff.delta", { fg = c.yellow })

-- LSP semantic tokens -------------------------------------------------------
set("@lsp.type.namespace",     { link = "@module" })
set("@lsp.type.type",          { link = "@type" })
set("@lsp.type.class",         { link = "@type" })
set("@lsp.type.enum",          { link = "@type" })
set("@lsp.type.interface",     { link = "@type" })
set("@lsp.type.struct",        { link = "@type" })
set("@lsp.type.parameter",     { link = "@variable.parameter" })
set("@lsp.type.variable",      { link = "@variable" })
set("@lsp.type.property",      { link = "@property" })
set("@lsp.type.enumMember",    { link = "@constant" })
set("@lsp.type.function",      { link = "@function" })
set("@lsp.type.method",        { link = "@function.method" })
set("@lsp.type.macro",         { link = "@function.macro" })
set("@lsp.type.decorator",     { link = "@attribute" })
set("@lsp.mod.deprecated",     { strikethrough = true })

-- Diagnostics ---------------------------------------------------------------
set("DiagnosticError", { fg = c.red })
set("DiagnosticWarn",  { fg = c.yellow })
set("DiagnosticInfo",  { fg = c.blue })
set("DiagnosticHint",  { fg = c.green })
set("DiagnosticOk",    { fg = c.green })

set("DiagnosticUnderlineError", { sp = c.red,    undercurl = true })
set("DiagnosticUnderlineWarn",  { sp = c.yellow, undercurl = true })
set("DiagnosticUnderlineInfo",  { sp = c.blue,   undercurl = true })
set("DiagnosticUnderlineHint",  { sp = c.green,  undercurl = true })

set("DiagnosticVirtualTextError", { fg = c.red,    bg = c.bg_dim, italic = true })
set("DiagnosticVirtualTextWarn",  { fg = c.yellow, bg = c.bg_dim, italic = true })
set("DiagnosticVirtualTextInfo",  { fg = c.blue,   bg = c.bg_dim, italic = true })
set("DiagnosticVirtualTextHint",  { fg = c.green,  bg = c.bg_dim, italic = true })

set("DiagnosticFloatingError", { fg = c.red,    bg = c.bg_float })
set("DiagnosticFloatingWarn",  { fg = c.yellow, bg = c.bg_float })
set("DiagnosticFloatingInfo",  { fg = c.blue,   bg = c.bg_float })
set("DiagnosticFloatingHint",  { fg = c.green,  bg = c.bg_float })

-- LSP references / inlay hints ----------------------------------------------
set("LspReferenceText",    { bg = c.bg_dim })
set("LspReferenceRead",    { bg = c.bg_dim })
set("LspReferenceWrite",   { bg = c.bg_dim, underline = true })
set("LspInlayHint",        { fg = c.fg_mute, bg = c.bg, italic = true })
set("LspSignatureActiveParameter", { fg = c.rust, bold = true })

-- gitsigns ------------------------------------------------------------------
set("GitSignsAdd",          { fg = c.green })
set("GitSignsChange",       { fg = c.yellow })
set("GitSignsDelete",       { fg = c.red })
set("GitSignsAddNr",        { fg = c.green })
set("GitSignsChangeNr",     { fg = c.yellow })
set("GitSignsDeleteNr",     { fg = c.red })
set("GitSignsCurrentLineBlame", { fg = c.fg_mute, italic = true })

-- Telescope -----------------------------------------------------------------
set("TelescopeNormal",         { fg = c.fg, bg = c.bg_float })
set("TelescopeBorder",         { fg = c.fg_mute, bg = c.bg_float })
set("TelescopePromptNormal",   { fg = c.fg, bg = c.bg_float })
set("TelescopePromptBorder",   { fg = c.fg_mute, bg = c.bg_float })
set("TelescopePromptTitle",    { fg = c.bg, bg = c.rust, bold = true })
set("TelescopePromptPrefix",   { fg = c.rust })
set("TelescopeResultsTitle",   { fg = c.bg, bg = c.blue, bold = true })
set("TelescopePreviewTitle",   { fg = c.bg, bg = c.green, bold = true })
set("TelescopeSelection",      { fg = c.fg, bg = c.bg_dim, bold = true })
set("TelescopeSelectionCaret", { fg = c.rust, bg = c.bg_dim })
set("TelescopeMatching",       { fg = c.rust, bold = true })
set("TelescopeMultiSelection", { fg = c.blue })

-- nvim-tree -----------------------------------------------------------------
set("NvimTreeNormal",            { fg = c.fg, bg = c.bg_float })
set("NvimTreeNormalNC",          { fg = c.fg, bg = c.bg_float })
set("NvimTreeRootFolder",        { fg = c.rust, bold = true })
set("NvimTreeFolderName",        { fg = c.blue })
set("NvimTreeOpenedFolderName",  { fg = c.blue, bold = true })
set("NvimTreeEmptyFolderName",   { fg = c.fg_mute })
set("NvimTreeFolderIcon",        { fg = c.yellow })
set("NvimTreeFileIcon",          { fg = c.fg_dim })
set("NvimTreeSpecialFile",       { fg = c.rust, italic = true })
set("NvimTreeExecFile",          { fg = c.green, bold = true })
set("NvimTreeImageFile",         { fg = c.rust })
set("NvimTreeIndentMarker",      { fg = c.fg_mute })
set("NvimTreeWinSeparator",      { fg = c.fg_mute, bg = c.bg_float })
set("NvimTreeGitDirty",          { fg = c.yellow })
set("NvimTreeGitNew",            { fg = c.green })
set("NvimTreeGitDeleted",        { fg = c.red })
set("NvimTreeGitStaged",         { fg = c.green })
set("NvimTreeGitMerge",          { fg = c.rust })
set("NvimTreeGitRenamed",        { fg = c.yellow })
set("NvimTreeGitIgnored",        { fg = c.fg_mute })

-- blink.cmp -----------------------------------------------------------------
set("BlinkCmpMenu",             { fg = c.fg, bg = c.bg_float })
set("BlinkCmpMenuBorder",       { fg = c.fg_mute, bg = c.bg_float })
set("BlinkCmpMenuSelection",    { fg = c.bg, bg = c.blue, bold = true })
set("BlinkCmpLabel",            { fg = c.fg })
set("BlinkCmpLabelDeprecated",  { fg = c.fg_mute, strikethrough = true })
set("BlinkCmpLabelMatch",       { fg = c.rust, bold = true })
set("BlinkCmpLabelDescription", { fg = c.fg_subtle })
set("BlinkCmpLabelDetail",      { fg = c.fg_subtle, italic = true })
set("BlinkCmpKind",             { fg = c.rust })
set("BlinkCmpKindFunction",     { fg = c.blue })
set("BlinkCmpKindMethod",       { fg = c.blue })
set("BlinkCmpKindVariable",     { fg = c.fg })
set("BlinkCmpKindKeyword",      { fg = c.rust })
set("BlinkCmpKindClass",        { fg = c.blue, bold = true })
set("BlinkCmpKindInterface",    { fg = c.blue })
set("BlinkCmpKindText",         { fg = c.green })
set("BlinkCmpKindSnippet",      { fg = c.yellow })
set("BlinkCmpDoc",              { fg = c.fg, bg = c.bg_float })
set("BlinkCmpDocBorder",        { fg = c.fg_mute, bg = c.bg_float })

-- indent-blankline ----------------------------------------------------------
set("IblIndent",     { fg = c.bg_dim })
set("IblWhitespace", { fg = c.bg_dim })
set("IblScope",      { fg = c.fg_mute })

-- which-key -----------------------------------------------------------------
set("WhichKey",          { fg = c.rust, bold = true })
set("WhichKeyGroup",     { fg = c.blue })
set("WhichKeyDesc",      { fg = c.fg })
set("WhichKeySeparator", { fg = c.fg_mute })
set("WhichKeyFloat",     { bg = c.bg_float })
set("WhichKeyBorder",    { fg = c.fg_mute, bg = c.bg_float })

-- Terminal ANSI colors ------------------------------------------------------
vim.g.terminal_color_0  = "#20111a"
vim.g.terminal_color_1  = "#bd100d"
vim.g.terminal_color_2  = "#858062"
vim.g.terminal_color_3  = "#e9a448"
vim.g.terminal_color_4  = "#416978"
vim.g.terminal_color_5  = "#96522b"
vim.g.terminal_color_6  = "#98999c"
vim.g.terminal_color_7  = "#958b83"
vim.g.terminal_color_8  = "#5e5252"
vim.g.terminal_color_9  = "#bd100d"
vim.g.terminal_color_10 = "#858062"
vim.g.terminal_color_11 = "#e9a448"
vim.g.terminal_color_12 = "#416978"
vim.g.terminal_color_13 = "#96522b"
vim.g.terminal_color_14 = "#98999c"
vim.g.terminal_color_15 = "#d4ccb9"
