" Write buffer before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 1
" 1= buffer, 2=commmandline (better undo history)

" Jedi settings ======================================================
let g:jedi#show_call_signatures = "2"
let g:jedi#popup_select_first = 1
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_definitions_command = "<leader>D"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<TAB>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#use_tabs_not_buffers = 0

" Ale settings ======================================================
let g:ale_completion_enabled = 0
let g:ale_python_pylint_use_global = 0
let g:ale_python_flake8_global = 1
"let g:ale_python_pylint_options = "--init-hook='import sys;
"sys.path.append(\'.\')'"
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_sign_error = "•⤫"
let g:ale_sign_warning = "•⚠"
let g:ale_sign_info = "••"
let g:ale_sign_hint = "•λ"
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = 'ALE: [%linter%] %s [%severity%]'
let b:ale_linters = {
      \  'python': ['pylint'],
      \  'sh': ['language_server'],
      \  'go': ['golint', 'gofmt', 'gopls']
      \}
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'javascript': ['eslint'],
      \   'python': ['autopep8'],
      \   'go': ['gofmt', 'goimports']
      \}

"vim-go settings ======================================================
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1 " highlight same variables
let g:go_fmt_command = "goimports" "autoimport
let g:go_auto_type_info = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mapping_enabled = 0 "Let language client handle goto
