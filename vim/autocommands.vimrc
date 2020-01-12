autocmd FileType python setlocal completeopt-=preview
au FileType go nmap <F9> :GoCoverageToggle -short<cr>
