"wintabs {{{1
let s:win_tabs_installed = IsInstalled('rgreenblatt/vim-wintabs')
function! WinTabBefore()
  if s:win_tabs_installed
    return "%{wintabs#get_tablist(0)}"
  else
    return ''
  endif
endfunction

function! WinTabCurrent()
  if s:win_tabs_installed
    return "%{wintabs#get_tablist(1)}"
  else
    return ''
  endif
endfunction

function! WinTabCurrentConditional()
  let total_len = len(wintabs#get_tablist(0)) + len(wintabs#get_tablist(1)) + 
        \ len(wintabs#get_tablist(2)) + 75
  if total_len > winwidth(".")
    return " "
  else
    return WinTabCurrent()
  endif
endfunction

function! WinTabAfter()
  if s:win_tabs_installed
    return "%{wintabs#get_tablist(2)}"
  else
    return ''
  endif
endfunction

let g:wintabs_marker_modified = " +"
let g:wintabs_marker_current = ""
let g:wintabs_separator = " "
let g:wintabs_number_separator = " "
let g:wintabs_only_basename = 1
let g:wintabs_show_number = 1
let g:wintabs_not_current_character_limit = 7

" macro mode info {{{1 
function! MacroModeInfo()
  if g:macro_mode == 1
    return "M"
  else
    return ""
  endif
endfunction

"short pwd {{{1
"requires shell script
function! ShortPwd()
  let out = substitute(system("cd ". getcwd() . " && short_pwd"), "\n", "", "")
  if v:shell_error
    return "error"
  else
    return out
  endif
endfunction

function! ShortPwdWrapper()
  return "%{ShortPwd()}"
endfunction


"blank {{{1
function! Blank()
  return ' '
endfunction

"status line {{{1
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'short_pwd', ],
      \             [  'readonly', ] ],
      \   'right': [ [ 'lineinfo'],
      \              [ 'filetype'  ],
      \              [ 'wintab_after', 'wintab_current_conditional', 
      \                'wintab_before' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'short_pwd' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [ 'wintab_after', 'wintab_current', 
      \               'wintab_before' ] ],
      \ },
      \ 'component_function': {
      \ },
      \ 'component_expand': {
      \   'wintab_before': 'WinTabBefore',
      \   'wintab_current': 'WinTabCurrent',
      \   'wintab_current_conditional': 'WinTabCurrentConditional',
      \   'wintab_after': 'WinTabAfter',
      \   'macromode': 'MacroModeInfo',
      \   'short_pwd': 'ShortPwdWrapper',
      \   'marker': 'Blank',
      \ },
      \ 'component_type': {
      \   'wintab_current': 'error',
      \   'wintab_current_conditional': 'error',
      \   'marker': 'error',
      \   'macromode': 'error',
      \ }
      \ }

"tabline {{{1
let g:lightline.tabline = {
      \ 'left': [ [ 'macromode', 'tabs' ] ],
      \ 'right': [ ] 
      \ }
"}}}1

" vim: set fdm=marker:
