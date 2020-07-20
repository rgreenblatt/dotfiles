"colorscheme{{{1
if IsInstalled('gruvbox-community/gruvbox')
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_italic = 1
  " let g:gruvbox_guisp_fallback = 'fg'
  colorscheme gruvbox

  function! SetColors()
    highlight TermCursor ctermfg=Red guifg=Red
    highlight link StartifyFooter GruvboxOrange
    if &background == 'dark'
      highlight Pmenu ctermfg=223 ctermbg=239 guifg=#ebdbb2 guibg=#282828
      highlight CursorLine ctermbg=239 guibg=#282828
      highlight CursorLineNr ctermbg=239 guibg=#282828
    endif
    highlight TerminalNormal cterm=reverse gui=reverse ctermfg=Blue guifg=Blue
    highlight TerminalInsert cterm=reverse gui=reverse ctermfg=Red guifg=Red

    highlight! link gitmessengerHeader GruvboxBlue
    highlight! link gitmessengerHash GruvboxYellow
    highlight! link gitmessengerHistory GruvboxRed
    highlight! link gitmessengerPopupNormal Pmenu
    highlight! link gitmessengerEndOfBuffer Pmenu
  endfunction

  augroup ColorSets
    autocmd!
    autocmd ColorScheme * call SetColors()
  augroup end
  
  call SetColors()
endif

" sneak/fFtT {{{1
let g:sneak#s_next = 1
let g:sneak#absolute_dir = 0

omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T

xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T

omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

"wintabs {{{1
let g:wintabs_delete_buffers = 0 
let g:wintabs_autoclose_vimtab = 1
let g:wintabs_buffer_limit = 5

"rooter {{{1
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1
let g:rooter_patterns = ['.root', 'build.sbt', 'stack.yaml', 'package.xml',
      \ 'build.sh', '.ccls', 'compile_commands.json', '.git', '.git/',
      \ '_darcs/', '.hg/', '.bzr/', '.svn/']

" other {{{1
let g:wordmotion_prefix = ';'
let g:lion_squeeze_spaces = 1
let g:windowswap_map_keys = 0
let g:dispatch_no_maps = 1
let g:miniyank_maxitems = 100
"}}}1

" vim: set fdm=marker:
