"colorscheme{{{1
if IsInstalled('gruvbox-community/gruvbox')
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_italic = 1
  " let g:gruvbox_guisp_fallback = 'fg'
  colorscheme gruvbox

  function! SetColors()
    highlight TermCursor ctermfg=Red guifg=Red
    highlight link StartifyFooter GruvboxOrange
    highlight Pmenu ctermfg=223 ctermbg=239 guifg=#ebdbb2 guibg=#282828
    highlight CursorLine ctermbg=239 guibg=#282828
    highlight CursorLineNr ctermbg=239 guibg=#282828
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

  function! s:ZshVIMModeEnterInsert()
    setlocal winhighlight=TermCursor:TerminalInsert
    redraw
  endfunction

  function! s:ZshVIMModeExitInsert()
    setlocal winhighlight=TermCursor:TerminalNormal
    redraw
  endfunction

  command! -nargs=0 ZshVIMModeExitInsert call s:ZshVIMModeExitInsert()
  command! -nargs=0 ZshVIMModeEnterInsert call s:ZshVIMModeEnterInsert()
else
  command! -nargs=0 ZshVIMModeExitInsert echo "normal"
  command! -nargs=0 ZshVIMModeEnterInsert echo "insert"
endif

"enhanced jumps{{{1
let g:EnhancedJumps_CaptureJumpMessages = 0
let g:EnhancedJumps_UseTab = 0

""cleverf options{{{1
"let g:clever_f_across_no_line = 1
"let g:clever_f_fix_key_direction = 0
"let g:clever_f_timeout_ms = 3000

if IsInstalled('neoclide/coc.nvim') "{{{1
  "coc {{{2
  let g:coc_global_extensions = [
        \ 'coc-word',
        \ 'coc-tag',
        \ 'coc-lists',
        \ 'coc-syntax',
        \ 'coc-emoji',
        \ 'coc-dictionary',
        \ 'coc-python',
        \ 'coc-json',
        \ 'coc-java',
        \ 'coc-vimtex',
        \ 'coc-yaml',
        \ 'coc-rls',
        \ 'coc-git',
        \ 'coc-highlight',
        \ 'coc-vimlsp',
        \ 'coc-snippets',
        \ 'coc-gocode',
        \ 'coc-sh',
        \]

  augroup CocGenericAutocmds
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType,BufWrite c,cpp,cuda,json,java,rust,tex,go,yaml,python,rust
          \ setlocal formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd CursorHold * silent call CocActionAsync('highlight')
  augroup end
  hi! CocHighlightText cterm=bold,underline gui=bold,underline
  
  "vista {{{2
  let g:vista_fzf_preview = ['right:50%']
  "}}}2
endif
"startify {{{1
let g:startify_change_to_dir = 0
let g:startify_files_number = 5
let g:startify_session_sort = 1


let g:startify_lists = [
      \ {'type': 'sessions',  'header': [' Sessions']},
      \ {'type': 'bookmarks', 'header': [' Bookmarks']},
      \ {'type': 'commands',  'header': [' Commands']},
      \ {'type': 'files',     'header': [' Recent']},
      \ ]
"possible additonal entry
"      \ { 'type': 'dir',       'header': ['   Recent: '. getcwd()] },

let g:startify_skiplist = [
      \ 'init.vim',
      \ 'config',
      \ 'config.py'
      \ ]

"calender {{{1
let g:calendar_google_task = 1
let g:calendar_google_calendar = 1
let g:calendar_view = 'week'
let g:calendar_cyclic_view = 1

augroup calendar-mappings
  autocmd!
  autocmd FileType calendar nunmap <buffer> <space>
augroup end

"vimtex {{{1
let g:tex_conceal="abdgm"
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_fold_enabled = 1
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

""semshi {{{1
"let g:semshi#error_sign = v:false
"let g:semshi#simplify_markup = v:false

""chromatica {{{1
"let g:chromatica#libclang_path = '/usr/lib/llvm-7/lib/libclang.so'
"" augroup ChromaticaStartup
""     autocmd!
""     autocmd FileType c,cpp,cuda ChromaticaStart
"" augroup end
"let g:chromatica#global_args = [
"      \ '-isystem /usr/lib/llvm-7/lib/clang/7.0.0/include'
"      \ ]
"let g:chromatica#responsive_mode = 1

""vimade {{{1
"augroup VimadeSpecial
"    autocmd!
"    autocmd CmdLineEnter * VimadeBufDisable
"    autocmd CmdlineLeave * VimadeBufEnable
"augroup END
"
" limelight/goyo {{{1
let g:limelight_conceal_ctermfg = 'DarkGray'

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

"codi {{{1
let g:codi#interpreters = {
      \ 'python': {
      \ 'bin': 'python3',
      \ },
      \ }

"c/cpp folding {{{1
let g:fold_options = {
      \ 'fallback_method' : { 'line_threshold' : 2000, 
      \ 'method' : 'syntax' },
      \ 'fold_blank': 0,
      \ 'fold_includes': 1,
      \ 'max_foldline_length': 'win',
      \ 'merge_comments' : 1,
      \ 'show_if_and_else': 1,
      \ 'strip_namespaces': 1,
      \ 'strip_template_arguments': 1
      \ }

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

  let s:fzf_window_option = 'call FloatingFullscreen()'

  "most of these zsh ones don't need to be vim functions
  function! ZshAliases()
    call fzf#run({'source': "zsh -c 'source ~/.zshrc && paste <(print -rl -- " .
          \ "${(k)aliases}) <(print -rl -- ${aliases})'",
          \ 'window': s:fzf_window_option})
  endfunction

  function! ZshFunctions()
    call fzf#run({
          \ 'source': "zsh -c 'source ~/.zshrc && print -rl -- ${(k)functions}'", 
          \ 'window': s:fzf_window_option,
          \ 'options' : "--preview 'zsh -c \"export NO_COMPLETE=true && ".
          \ "source ~/.zshrc && which {}\"'"})
  endfunction

  function! ZshVariables()
    call fzf#run({
          \ 'source': "zsh -c 'source ~/.zshrc && paste <(print -rl -- " .
          \ " ${(k)parameters}) <(print -rl -- ${parameters}) '", 
          \ 'window': s:fzf_window_option,
          \ 'options' : "--preview 'zsh -c \"export NO_COMPLETE=true && ".
          \ "source ~/.zshrc && get_value {}\"'"})
  endfunction

  function! ZshExecutables()
    call fzf#run({
          \ 'source': "zsh -c 'source ~/.zshrc && whence -pm \"*\"'", 
          \ 'sink': 'e',
          \ 'window': s:fzf_window_option,
          \ 'options' : fzf#vim#with_preview('right:50%').options})
  endfunction

  function! RgPreviewHidden(args, extra_args)
    call RgPreview(a:args, '--hidden --glob "!.git/*" ' . a:extra_args)
  endfunction

  command! -nargs=* RgPreview call RgPreview(<q-args>, '')
  command! -nargs=* RgPreviewHidden call RgPreviewHidden(<q-args>, '')
  command! ZshAliases call ZshAliases()
  command! ZshFunctions call ZshFunctions()
  command! ZshVariables call ZshVariables()
  command! ZshExecutables call ZshExecutables()

  let g:fzf_layout = { 'window': s:fzf_window_option }

  "Too slow
  "
  " let g:fzf_preview_window = -1
  "
  "function! FloatingFZFPreview(path, line_num)
  "  if g:fzf_window != -1 && nvim_win_is_valid(g:fzf_window)
  "    echom "started_preview"
  "    let win_config = nvim_win_get_config(g:fzf_window)
  "    let win_config.width = float2nr(&columns / 2)
  "    call nvim_win_set_config(g:fzf_window, win_config)
  "    let g:orig_win = nvim_get_current_win()
  "    if g:fzf_preview_window != -1 && nvim_win_is_valid(g:fzf_preview_window)
  "      call nvim_win_close(g:fzf_preview_window, 0)
  "      let g:fzf_preview_window = -1
  "    endif
  "    let buf = nvim_create_buf(v:false, v:true)
  "    let orig_mode = mode()

  "    "window size
  "    let height = &lines - 1 - &cmdheight
  "    let width = float2nr(&columns / 2)

  "    let opts = {
  "          \ 'relative': 'editor',
  "          \ 'row': 0,
  "          \ 'col': &columns - width,
  "          \ 'width': width,
  "          \ 'height': height
  "          \ }

  "    " not sure why before and after is required
  "    let g:fzf_preview_window = nvim_open_win(buf, v:false, opts)
  "    call win_gotoid(g:fzf_preview_window)
  "    execute "edit " . a:path
  "    normal! zR
  "    call win_gotoid(g:orig_win)
  "    call nvim_win_set_option(g:fzf_preview_window, "winhighlight", 
  "          \ "NormalFloat:Normal")
  "    call nvim_win_set_option(g:fzf_preview_window, "signcolumn", 
  "          \ "no")
  "    echom "finished_preview"
  "    return g:fzf_preview_window
  "  else
  "    echom "not preview"
  "    return -1
  "  endif
  "endfunction

  " function! FZFCheckWindow()
  "   if g:fzf_window != -1 && g:fzf_preview_window != -1  && 
  "         \ !nvim_win_is_valid(g:fzf_window) && 
  "         \ nvim_win_is_valid(g:fzf_preview_window)
  "     call nvim_win_close(g:fzf_preview_window, 0)
  "     let g:fzf_preview_window = -1
  "   endif
  " endfunction

  " augroup FzfWindowHandler
  "   autocmd!
  "   autocmd WinEnter * call FZFCheckWindow()
  " augroup end 

  " let g:fzf_window = -1

  " function! FloatingFZF()
  "   let g:fzf_window = FloatingFullscreen()
  " endfunction
endif

"rainbow parens {{{1
let g:rainbow_active = 1
let g:rainbow_conf = {
      \	'guifgs': ['#83a598', '#fe8019', '#b8bb26', '#fb4934'],
      \	'ctermfgs': ['109', '208', '142', '167'],
      \	'operators': '_,_',
      \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 
      \                 'start=/{/ end=/}/ fold'],
      \	'separately': {
      \		'lisp': {
      \			'guifgs': ['#83a598', '#fe8019', '#b8bb26', '#fb4934'],
      \		},
      \		'css': 0,
      \	}
      \}

"wintabs {{{1
let g:wintabs_delete_buffers = 0 
let g:wintabs_autoclose_vimtab = 1
let g:wintabs_buffer_limit = 5

"autoformat {{{1
autocmd FileType,BufWrite cmake nnoremap <buffer> <space>F <Cmd>Autoformat<cr>

let g:formatdef_cmake_format = '"cmake-format --tab-size " . &shiftwidth . " -"'
let g:formatters_cmake = ['cmake_format']
"
"polyglot and associated plugins: {{{1
let g:polyglot_disabled = ['latex']
"if I ever start working with csvs some, look into plugin
let g:no_csv_maps = 1

"sneak quick scope {{{1
let g:sqs_enable = 1
nmap ;vs <plug>(SneakQuickScopeToggle)

"dirvish {{{1
function! DirvishFoldHiddenText()
  let names = []
  let i = v:foldstart
  while i <= v:foldend
    call add(names, matchlist(getline(i), '\/\(\(.*\/.\)\@!.*$\)')[1])
    let i += 1
  endwhile
  return join(names, " ")
endfunction

function! DirvishSetup()
  "This assumes it is sorted with hidden at bottom which should be true
  let hidden_pattern = '\(\/\.\)\@<=\(.*\/.\)\@!'
  let line_first_hidden = search(hidden_pattern)
  if line_first_hidden
    let sort_dirs = 'sort ,^.*[\/],'
    execute string(line_first_hidden) . ',$' . sort_dirs
    if line_first_hidden > 1
      execute '1,' . string(line_first_hidden - 1) . sort_dirs
    endif
  else
    sort ,^.*[\/],
  endif
  execute 'setlocal foldexpr=' . escape("match(getline(v:lnum), '" . 
        \ hidden_pattern . "') != -1", ' \')
  setlocal foldmethod=expr
  setlocal foldtext=DirvishFoldHiddenText()
endfunction

let g:dirvish_mode = 'call DirvishSetup()'

"rooter {{{1
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1
let g:rooter_patterns = ['build.sbt', 'package.xml', 'build.sh', '.ccls',
      \ 'compile_commands.json', '.git', '.git/', '_darcs/', '.hg/', '.bzr/',
      \ '.svn/']

"ale {{{1
let g:ale_virtualtext_cursor = 1
let g:ale_sign_error = "❌"
let g:ale_sign_warning = "‼"
let g:ale_virtualtext_prefix = "◀ "

let g:ale_disable_lsp = 1
" let g:ale_linters = {'cpp': ['cpplint', 'clangtidy']}
let g:ale_linters = {
      \ 'cpp': ['cpplint'], 
      \ 'python': ['pylint'], 
      \ 'c': [], 
      \ 'rust': []
      \ }
let g:ale_echo_msg_format = '[%linter%] %s [%code%]'

hi ALEVirtualTextError cterm=italic ctermfg=167 gui=italic guifg=#fb4934
hi ALEVirtualTextWarning cterm=italic ctermfg=214 gui=italic guifg=#fabd2f
hi ALEVirtualTextInfo cterm=italic ctermfg=245 gui=italic guifg=#928374
hi link ALEVirtualTextStyleError ALEVirtualTextError
hi link ALEVirtualTextStyleWarning ALEVirtualTextWarning

"ros {{{1
let g:ros_build_system = 'catkin-tools'
"is this really needed?
let g:ros_catkin_make_options = '-DCMAKE_EXPORT_COMPILE_COMMANDS=1'

"rust {{{1
let g:rust_conceal = 1
let g:rust_conceal_mod_path = 1
let g:rust_conceal_pub = 1
let g:rust_fold = 2

" other {{{1
let g:wordmotion_prefix = ';'
let g:lion_squeeze_spaces = 1
let g:windowswap_map_keys = 0
let g:mwAutoLoadMarks = 1
let g:gutentags_cache_dir = '~/.tags'
let g:highlightedyank_highlight_duration = 200
let g:localvimrc_name = ['.config/local_init.vim']
let g:localvimrc_whitelist = [$HOME . '/documents', $HOME . '/locus_dev']
let g:dispatch_no_maps = 1
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
let g:miniyank_maxitems = 100
"}}}1

" vim: set fdm=marker:
