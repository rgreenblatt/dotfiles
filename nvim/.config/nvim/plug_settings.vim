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

if IsInstalled('neoclide/coc.nvim') "{{{1
  "coc {{{2
  highlight! link CocErrorHighlight SpellBad
  highlight CocWarningHighlight cterm=undercurl gui=undercurl guisp=#fabd2f
  highlight CocWarningSign ctermfg=214 guifg=#fabd2f ctermbg=234 guibg=#1d2021
  highlight CocErrorSign ctermfg=167 guifg=#fb4934 ctermbg=234 guibg=#1d2021

  augroup CocGenericAutocmds
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType,BufWrite c,cpp,cuda,json
          \ setlocal formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end
  hi! CocHighlightText cterm=bold,underline gui=bold,underline
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

"fzf {{{1
if IsInstalled('junegunn/fzf') && IsInstalled('rgreenblatt/fzf.vim')
  function! RgPreview(args, extra_args)
    call fzf#vim#grep("rg --column --line-number --no-heading " .
          \ "--color=always --smart-case " . a:extra_args . " " .
          \ shellescape(a:args), 1, {'options' : 
          \ fzf#vim#with_preview('right:50%').options + 
          \ ['--bind', 'alt-e:execute-silent(remote_tab_open_grep {} &)']})
  endfunction

  function! RgPreviewHidden(args, extra_args)
    call RgPreview(a:args, '--hidden --glob "!.git/*" ' . a:extra_args)
  endfunction

  command! -nargs=* RgPreview call RgPreview(<q-args>, '')
  command! -nargs=* RgPreviewHidden call RgPreviewHidden(<q-args>, '')

  let g:fzf_layout = { 'window': 'call FloatingFullscreen()' }
endif

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
