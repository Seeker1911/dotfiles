local ok, null_ls = pcall(require, "null-ls")
if not ok then
  print("NULL_LS NOT FOUND")
  return
end
local b = null_ls.builtins

local sources = {
  -- markdown diagnostic
  b.diagnostics.markdownlint.with { filetypes = { "markdown" }},

  -- shell
  b.code_actions.shellcheck,
  b.diagnostics.shellcheck,

  -- python formatting
  b.formatting.black.with { filetypes = { "python" }},
  b.formatting.isort.with { filetypes = { "python" }},
  b.diagnostics.mypy.with { filetypes = { "python" }},

  -- snippets
  b.completion.luasnip,

  -- NOTE: ex. of custom commands
  -- b.diagnostics.mypy.with({
  --     command = vim.fn.system({ "which", "mypy" }):gsub("[\n]", ""),
  --     print(vim.fn.system({ "which", "mypy" }):gsub("[\n]", "")),
  --
  --    }),

  -- Run a tool only if in specific directory
  -- b.diagnostics.pylint.with({
    --     cwd = function(params)
    --         -- falls back to root if return value is nil
    --         return params.root:match("my-special-project") and "my-special-cwd"
    --     end,
    -- }),
}

-- formatting on save
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
    log_level = "error",
    debug = false,
    sources = sources,
    diagnostics_format ="(#{s}) [#{c}] #{m}",
    notify_format = "[NULL-LS] %s",
    on_attach = on_attach,
}
