" maps =================================
map <leader>t :NERDTreeToggle<CR>
" Adjust viewports to the same size
map <Leader>= <C-w>=
map <leader>m :MundoToggle<CR>
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" ripgrep fzf find word under cursor in nearby files.
map <leader>F :Rg<CR>
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nmap <LocalLeader>l :LightSide<CR>
nmap <LocalLeader>d :DarkSide<CR>
nmap <leader>T :TagbarToggle<CR>
nmap <LocalLeader>p :ProseMode<CR>

" visual maps ==================================
vmap <leader>" :s/^/"/g<CR>

" insert maps ==================================
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<CR>"
inoremap jj <ESC>
inoremap JJ <ESC>

" normal maps ====================================
" surround word with "
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <nowait> <silent> <leader>h :set hlsearch<cr>
nnoremap <nowait> <silent> <leader>nh :set nohlsearch<cr>
" use space to fold/unfold
nnoremap <space> za
" open all folds
nnoremap <leader>zr zR
" close all folds
nnoremap <leader>zm zM
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap ]c :cnext <CR>
nnoremap [c :cprevious <CR>
nnoremap ]l :lnext <CR>
nnoremap [l :lprevious <CR>
nnoremap <leader>pdb oimport ipdb; ipdb.set_trace()<ESC>
nnoremap <silent> <c-u> :call <sid>smoothScroll(1)<cr>
nnoremap <silent> <c-d> :call <sid>smoothScroll(0)<cr>

