local M = {}

M.diagnostic_config = function()
    local x = vim.diagnostic.severity

    vim.diagnostic.config({
        virtual_text = { prefix = "" },
        signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
        underline = true,
        float = { border = "single", source = true },
    })

    local unused_ts_codes = { [6133] = true, [6196] = true, [6138] = true }

    local orig_set = vim.diagnostic.set
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
        local has_eslint = #vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" }) > 0
        if has_eslint then
            diagnostics = vim.tbl_filter(function(d)
                return not (d.source == "typescript" and unused_ts_codes[d.code])
            end, diagnostics)
        end
        return orig_set(namespace, bufnr, diagnostics, opts)
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = "rounded"
        opts.max_width = math.floor(vim.o.columns * 0.7)
        opts.max_height = math.floor(vim.o.lines * 0.6)
        opts.wrap = true
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
end

return M
