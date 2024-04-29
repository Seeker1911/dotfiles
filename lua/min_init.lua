--- CHANGE THESE
local pattern = 'typescript'
local cmd = {'typescript-language-server.cmd', '--stdio'}
-- Add files/folders here that indicate the root of a project
local root_markers = {'.git', '.editorconfig', '.tsconfig'}
-- Change to table with settings if required
local settings = vim.empty_dict()

vim.api.nvim_create_autocmd('FileType', {
    pattern = pattern,
    callback = function(args)
        local match = vim.fs.find(root_markers, { path = args.file, upward = true })[1]
        local root_dir = match and vim.fn.fnamemodify(match, ':p:h') or nil
        vim.lsp.start({
            name = 'bugged-ls',
            cmd = cmd,
            root_dir = root_dir,
            settings = settings
        })
    end
})
