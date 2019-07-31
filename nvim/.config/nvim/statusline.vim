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

"coc wrappers {{{1
let s:coc_installed = IsInstalled('neoclide/coc.nvim')

function! CocStatusWrapper()
  if s:coc_installed
    let out = coc#status()
    let out = substitute(out, 'Python', '', '')
    let out = substitute(out, ' 64-bit', '', '')
    let out = substitute(out, 'Analyzing in background, ', '', '')
    let out = substitute(out, 'items left...', 'left', '')
    return out
  endif
  return ''
endfunction

let s:coc_git_status_character_limit = 20

function! CocGitGlobalStatusWrapper()
  if s:coc_installed && exists("g:coc_git_status")
    let s:coc_git_status = g:coc_git_status[4:]
    if len(g:coc_git_status) > (s:coc_git_status_character_limit + 1)
      return s:coc_git_status[:s:coc_git_status_character_limit - 1] .
            \ g:wintabs_marker_cutoff
    else
      return s:coc_git_status
    endif
  endif
  return ''
endfunction

function! CocGitBufferStatusWrapper()
  if s:coc_installed && exists("b:coc_git_status")
      return trim(b:coc_git_status)
  endif
  return ''
endfunction

"blank {{{1
function! Blank()
  return ' '
endfunction

"ale wrappers {{{1
let s:ale_installed = IsInstalled('w0rp/ale') &&
      \ IsInstalled('maximbaz/lightline-ale')

function! AleCheckingWrapper()
  if s:ale_installed
    return '%{lightline#ale#checking()}'
  else
    return ''
  endif
endfunction

function! AleWarningsWrapper()
  if s:ale_installed
    return '%{lightline#ale#warnings()}'
  else
    return ''
  endif
endfunction

function! AleErrorsWrapper()
  if s:ale_installed
    return '%{lightline#ale#errors()}'
  else
    return ''
  endif
endfunction

function! AleOkWrapper()
  if s:ale_installed
    return '%{lightline#ale#ok()}'
  else
    return ''
  endif
endfunction

"status line {{{1
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'short_pwd', ],
      \             [ 'cocstatus', 'git_buffer_status', 'linter_checking', 
      \               'linter_errors', 'linter_warnings', 'linter_ok', 
      \               'readonly', ] ],
      \   'right': [ [ 'lineinfo'],
      \              [ 'filetype'  ],
      \              [ 'wintab_after', 'wintab_current_conditional', 
      \                'wintab_before' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'short_pwd', 'git_buffer_status', 'linter_checking', 
      \               'linter_errors', 'linter_warnings', 'linter_ok', ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [ 'wintab_after', 'wintab_current', 
      \               'wintab_before' ] ],
      \ },
      \ 'component_function': {
      \   'cocstatus': 'CocStatusWrapper',
      \   'git_global_status': 'CocGitGlobalStatusWrapper',
      \   'git_buffer_status': 'CocGitBufferStatusWrapper',
      \ },
      \ 'component_expand': {
      \   'wintab_before': 'WinTabBefore',
      \   'wintab_current': 'WinTabCurrent',
      \   'wintab_current_conditional': 'WinTabCurrentConditional',
      \   'wintab_after': 'WinTabAfter',
      \   'macromode': 'MacroModeInfo',
      \   'short_pwd': 'ShortPwdWrapper',
      \   'linter_checking': 'AleCheckingWrapper',
      \   'linter_warnings': 'AleWarningsWrapper',
      \   'linter_errors': 'AleErrorsWrapper',
      \   'linter_ok': 'AleOkWrapper',
      \   'marker': 'Blank',
      \ },
      \ 'component_type': {
      \   'wintab_current': 'error',
      \   'wintab_current_conditional': 'error',
      \   'marker': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'macromode': 'error',
      \ }
      \ }

"tabline {{{1
let g:lightline.tabline = {
      \ 'left': [ ['git_global_status', 'macromode', 'tabs' ] ],
      \ 'right': [ ] 
      \ }
"}}}1

" vim: set fdm=marker:
