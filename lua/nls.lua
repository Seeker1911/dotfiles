local ok, null_ls = pcall(require, "null-ls")
if not ok then
  print("NULL_LS NOT FOUND")
  return
end
local b = null_ls.builtins

local sources = {
  -- format html and markdown
  b.formatting.prettierd.with { filetypes = { "html", "yaml", "markdown" } },
  -- markdown diagnostic
  b.diagnostics.markdownlint.with { filetypes = { "markdown" }},
  -- python formatting
  b.formatting.black.with { filetypes = { "python" }},
  b.formatting.isort.with { filetypes = { "python" }},
  -- TODO: mypy: [import] Cannot find implementation or library stub for module named "im" (mypy)
  b.diagnostics.mypy.with { filetypes = { "python" }},
  b.completion.luasnip,
  -- TODO: worth investigation
  -- b.diagnostics.ruff.with { filetypes = { "python" }},
  -- b.formatting.ruff,
  --
  -- NOTE: ex. of custom command
  -- b.diagnostics.mypy.with({
  --     command = vim.fn.system({ "which", "mypy" }):gsub("[\n]", ""),
  --     print(vim.fn.system({ "which", "mypy" }):gsub("[\n]", "")),
  --
  --    }),
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        -- < 0.8 use vim.lsp.buf.formatting_sync()
        vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })
  end
end
null_ls.setup {
  debug = false,
  sources = sources,
  diagnostics_format ="[#{c}] #{m} (#{s})",
  notify_format = "[NULL-LS] %s",
  on_attach = on_attach,
  root_dir = function() return vim.loop.cwd() end,
}
