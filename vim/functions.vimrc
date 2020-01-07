function! LightSide()
    colors snow
    set background=light
    let g:airline_theme='papercolor'
    endfunction
command! LightSide call LightSide()

function! DarkSide()
    colors gruvbox
    set background=dark
    let g:airline_theme='distinguished'
    endfunction
command! DarkSide call DarkSide()

function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
  if !has('gui_running')
    let g:solarized_termcolors=256
  endif
  colors vimspectrgrey-light
endfunction
command! ProseMode call ProseMode()

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:smoothScroll(up)
    execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
    redraw
    for l:count in range(3, &scroll, 2)
      sleep 7m
      execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
      redraw
    endfor
    " bring the cursor in the middle of screen 
    execute "normal M"
endf

