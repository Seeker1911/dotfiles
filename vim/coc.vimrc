nmap <leader>rn <Plug>(coc-rename)
" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)
" coc open browser current file
nnoremap <leader>bo :call CocAction('runCommand', 'git.browserOpen')<CR>
" navigate chunks of current buffer
nmap <silent> [g <Plug>(coc-git-prevchunk)
nmap <silent> ]g <Plug>(coc-git-nextchunk)
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>ct <Plug>(coc-terminal-toggle)
"coc action
 nnoremap <silent> <space>a :<C-u>CocAction<CR>
" Show all diagnostics
nnoremap <silent> <space>d :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<CR>
" Search workspace symbols
noremap <silent> <space>s :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Remap for format selected region need to fix
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
" Show config
nnoremap <silent> <space>g :<C-u>CocConfig<CR>
" Show info
nnoremap <silent> <space>i :<C-u>CocInfo<CR>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<CR>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>
imap <C-l> <Plug>(coc-snippets-expand)

