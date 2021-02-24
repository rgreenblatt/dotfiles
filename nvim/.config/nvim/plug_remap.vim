"better jumping (uses vim-EnhancedJumps) {{{1
function! MapTab()
  if IsInstalled('neoclide/coc.nvim')
    noremap <silent><expr> <tab>
          \ coc#expandableOrJumpable() ?
          \ coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
          \ "\<c-o>"
    noremap <silent><expr> <s-tab>
          \ coc#expandableOrJumpable() ?
          \ coc#rpc#request('snippetPrev', []) :
          \ "\<c-i>"
  else
    noremap <tab> <c-o>
    noremap <s-tab> <c-i>
  endif
endfunction

call MapTab()

nmap g<tab> <Plug>EnhancedJumpsLocalOlder
nmap g<s-tab> <Plug>EnhancedJumpsLocalNewer

nmap <space><tab> <Plug>EnhancedJumpsRemoteOlder
nmap <space><s-tab> <Plug>EnhancedJumpsRemoteNewer

nmap z;  <Plug>EnhancedJumpsFarFallbackChangeOlder
nmap z,  <Plug>EnhancedJumpsFarFallbackChangeNewer

"fzf maps {{{1
call MapWinCmd("f", "Files", 0)
call MapWinCmd("F", "Files ", 1)
call MapWinCmd("'", "GFiles?", 0)
call MapWinCmd("g", "GFiles", 0)
call MapWinCmd("G", "GFiles ", 1)
call MapWinCmd("r", "RgPreviewHidden ", 1)
call MapWinCmd("R", "RgPreviewHidden", 0)
call MapWinCmd(";r", "RgPreview ", 1)
call MapWinCmd(";R", "RgPreview", 0)
call MapWinCmd("l", "BLines", 0)
call MapWinCmd("L", "Lines", 0)
call MapWinCmd(";t", "Tags", 0)
call MapWinCmd(";T", "BTags", 0)
call MapWinCmd("m", "call fzf#vim#marks()", 0)
call MapWinCmd("h", "History", 0)
call MapWinCmd("q", "Commits", 0)
call MapWinCmd("Q", "BCommits", 0)
call MapWinCmd("o", "commands", 0)
call MapWinCmd("b", "Buffers", 0)
call MapWinCmd("E", "ZshExecutables", 0)

nnoremap <Space>B <Cmd>Wipeouts<cr>
nnoremap <M-C-B> <Cmd>Buffers<cr>
nnoremap <M-C-N> <Cmd>GFiles<cr>
nnoremap <M-C-A> <Cmd>Commits<cr>
nnoremap <M-C-F> <Cmd>Files<cr>
nnoremap <M-C-G> :<c-u>RgPreviewHidden<space>
nnoremap <M-C-H> <Cmd>History/<cr>
nnoremap <M-C-P> <Cmd>Lines<cr>
nnoremap <space>: <Cmd>History:<cr>

nnoremap <F1> :<c-u>RgPreviewHidden<space>
nnoremap <F2> <Cmd>Buffers<cr>
nnoremap <F3> <Cmd>GFiles<cr>
nnoremap <F4> <Cmd>Files<cr>
nnoremap <F5> <Cmd>Lines<cr>
nnoremap <F6> <Cmd>BLines<cr>
nnoremap <F7> <Cmd>Commits<cr>
nnoremap <F8> :<c-u>call RgPreviewHidden('','')<left><left><left><left><left>
nnoremap <F9> <Cmd>terminal<cr>

"dirvish in new window {{{1
call MapWinCmd("d", "Dirvish", 0)

"startify in new window {{{1
call MapWinCmd("s", "Startify", 0)

if IsInstalled('neoclide/coc.nvim') " {{{1
  "coc remaps {{{2
  " use <tab> for trigger completion and navigate to next complete item
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ coc#expandableOrJumpable() ?
        \ coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr> <S-Tab>
        \ pumvisible() ? "\<C-p>" :
        \ coc#expandableOrJumpable() ?
        \ coc#rpc#request('snippetPrev', []) : "\<S-Tab>"

  snoremap <silent><expr> <TAB>
        \ coc#expandableOrJumpable() ?
        \ coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
        \ "\<TAB>"
  snoremap <silent><expr> <S-TAB>
        \ coc#expandableOrJumpable() ?
        \ coc#rpc#request('snippetPrev', []) :
        \ "\<S-TAB>"

  "pum close/break undo
  inoremap <c-space> <c-g>u

  "snippet trigger
  imap <C-s> <Plug>(coc-snippets-expand)

  inoremap <silent><expr> <cr> pumvisible() && !empty(v:completed_item) ?
        \ coc#_select_confirm()
        \: "\<CR>"

  nnoremap <space>I <Cmd>CocCommand python.sortImports<cr>
  nnoremap <space>R <Cmd>CocCommand python.execInTerminal<cr>
  nnoremap ;L :<c-u>CocList<space>
  nnoremap ;A :<c-u>CocCommand<space>
  nnoremap ;D <Cmd>CocList --auto-preview diagnostics<cr>
  nnoremap ;O <Cmd>CocList --auto-preview outline<cr>
  nnoremap ;f <Cmd>CocList --auto-preview files<cr>

  " nmap <space>O <Plug>(coc-openlink)
  " nmap <space>E <Plug>(coc-codelens-action)

  " Remap keys for gotos
  nmap <space>D <Plug>(coc-declaration)
  nmap <space>d <Plug>(coc-definition)
  nmap <space>o <Plug>(coc-type-definition)

  nmap <space>i <Plug>(coc-implementation)
  nmap <space>u <Plug>(coc-references-used)

  nmap <space>e <Plug>(coc-rename)

  nmap <space>c <Plug>(coc-fix-current)

  " nmap <space>C <Plug>(coc-codeaction)

  " nmap <space>a <Plug>(coc-codeaction-selected)
  " xmap <space>a <Plug>(coc-codeaction-selected)

  " nmap <space>Z <Plug>(coc-float-jump)

  "show documentation in preview window
  nnoremap <silent> K <Cmd>call CocAction('doHover')<CR>
  xnoremap <silent> K <Cmd>call CocAction('doHover')<CR>

  "coc-git
  nmap [c <plug>(coc-git-prevchunk)
  nmap ]c <plug>(coc-git-nextchunk)
  nmap gs <Cmd>CocCommand git.chunkStage<cr>
  nmap <space>G <plug>(coc-git-chunkinfo)
  nmap ;gu <Cmd>CocCommand git.chunkUndo<cr>

  "diagnostics
  nmap [g <plug>(coc-diagnostic-prev)
  nmap ]g <plug>(coc-diagnostic-next)
  nmap [G <plug>(coc-diagnostic-first)
  nmap ]G <plug>(coc-diagnostic-last)


  "vista {{{2
  nnoremap <silent> <space>V <Cmd>Vista!!<cr>
  "}}}2
endif

"vimtex {{{1
let g:vimtex_mappings_enabled = 0

" nmap  <space>xi   <plug>(vimtex-info)
" nmap  <space>xI   <plug>(vimtex-info-full)
" nmap  <space>xt   <plug>(vimtex-toc-open)
" nmap  <space>xT   <plug>(vimtex-toc-toggle)
" nmap  <space>xq   <plug>(vimtex-log)
" nmap  <space>xv   <plug>(vimtex-view)
" nmap  <space>xr   <plug>(vimtex-reverse-search)
nmap  <space>xl   <plug>(vimtex-compile)
" nmap  <space>xL   <plug>(vimtex-compile-selected)
" nmap  <space>xL   <plug>(vimtex-compile-selected)
" nmap  <space>xk   <plug>(vimtex-stop)
" nmap  <space>xK   <plug>(vimtex-stop-all)
nmap  <space>xe   <plug>(vimtex-errors)
" nmap  <space>xo   <plug>(vimtex-compile-output)
" nmap  <space>xg   <plug>(vimtex-status)
" nmap  <space>xG   <plug>(vimtex-status-all)
" nmap  <space>xc   <plug>(vimtex-clean)
" nmap  <space>xC   <plug>(vimtex-clean-full)
" nmap  <space>xm   <plug>(vimtex-imaps-list)
" nmap  <space>xx   <plug>(vimtex-reload)
" nmap  <space>xX   <plug>(vimtex-reload-state)
" nmap  <space>xs   <plug>(vimtex-toggle-main)

""insertchar options {{{1
"let g:insert_char_no_default_mapping = 1
"nmap <space>s <Plug>InsertChar
"nmap <space>S <Plug>InsertCharAfter
"
"yankring {{{1
if IsInstalled('bfredl/nvim-miniyank')
  function! FZFYankList() abort
    function! KeyValue(key, val)
      let line = join(a:val[0], '\n')
      if (a:val[1] ==# 'V')
        let line = '\n'.line
      endif
      return a:key.' '.line
    endfunction
    return map(miniyank#read(), function('KeyValue'))
  endfunction

  function! FZFYankHandler(opt, line) abort
    let key = substitute(a:line, ' .*', '', '')
    if !empty(a:line)
      let yanks = miniyank#read()[key]
      call miniyank#drop(yanks, a:opt)
    endif
  endfunction

  command! Yanks call fzf#run(fzf#wrap('YanksBefore', {
        \ 'source':  FZFYankList(),
        \ 'sink':    function('FZFYankHandler', ['P']),
        \ 'options': '--no-sort --prompt="Yanks-P> "',
        \ }))

  nnoremap <F10> <Cmd>Yanks<CR>

  nmap p <Plug>(miniyank-autoput)
  nmap P <Plug>(miniyank-autoPut)
  xmap p <Plug>(miniyank-autoput)
  xmap P <Plug>(miniyank-autoPut)

  nmap ;n <Plug>(miniyank-cycle)
  nmap ;N <Plug>(miniyank-cycleback)
endif

"custom operators {{{1
if IsInstalled('kana/vim-operator-user')
  "substitute region {{{2
  "TODO:
  "work for other commands?
  xmap ;s <Plug>(substitute-region)
  xmap ;S <Plug>(subvert-region)
  nmap ;s <Plug>(substitute-region)
  nmap ;S <Plug>(subvert-region)

  xmap ;r <Plug>(substitute-region-g)
  xmap ;R <Plug>(subvert-region-g)
  nmap ;r <Plug>(substitute-region-g)
  nmap ;R <Plug>(subvert-region-g)

  xmap ;c <Plug>(substitute-region-c)
  xmap ;C <Plug>(subvert-region-c)
  nmap ;c <Plug>(substitute-region-c)
  nmap ;C <Plug>(subvert-region-c)

  xmap ;;s <Plug>(substitute-region-exact)
  xmap ;;S <Plug>(subvert-region-exact)
  nmap ;;s <Plug>(substitute-region-exact)
  nmap ;;S <Plug>(subvert-region-exact)

  xmap ;;r <Plug>(substitute-region-g-exact)
  xmap ;;R <Plug>(subvert-region-g-exact)
  nmap ;;r <Plug>(substitute-region-g-exact)
  nmap ;;R <Plug>(subvert-region-g-exact)

  xmap ;;c <Plug>(substitute-region-c-exact)
  xmap ;;C <Plug>(subvert-region-c-exact)
  nmap ;;c <Plug>(substitute-region-c-exact)
  nmap ;;C <Plug>(subvert-region-c-exact)

  xmap ;z <Plug>(substitute-region-edit)
  xmap ;Z <Plug>(subvert-region-edit)
  nmap ;z <Plug>(substitute-region-edit)
  nmap ;Z <Plug>(subvert-region-edit)

  function! SubstituteRegionMakeMap(plug_name, command, flags, pattern_alter,
        \ replace_alter, ...)

    let edit_flags = a:0 && a:1

    let start_map = "map <silent> <Plug>(" . a:plug_name .
          \ ") <Cmd>call SubstituteRegionSetup('" . a:command .
          \ "', '".  a:flags . "', '" . a:pattern_alter . "', '" .
          \ a:replace_alter .  "', '" . edit_flags . "')<cr>"
    let start_xmap = "x" . start_map
    let start_nmap = "n" . start_map
    let end_xmap = "<Plug>(substitute-region-visual-finish)"
    let end_nmap = "."
    execute start_xmap . end_xmap
    execute start_nmap . end_nmap
  endfunction

  "source:
  "https://stackoverflow.com/questions/53498121/all-the-special-characters-that-need-escaping-in-vim-pattern-searching-replacmen
  function! SubstitutePatternEscape(str)
    return '\V\C' . substitute(escape(a:str, '/\'), "\n", '\\n', 'ge')
  endfunction

  function! SubstituteReplaceEscape(str)
    return escape(a:str, '/\' . (&magic ? '&~' : ''))
  endfunction

  "note, { and } can't be effectively escaped for subvert...
  function! SubvertPatternEscape(str)
    return substitute(escape(a:str, '/\'), "\n", '\\n', 'ge')
  endfunction

  function! SubvertReplaceEscape(str)
    return a:str
  endfunction

  function! SubstitutePatternEscapeExact(str)
    return '\V\C' . '\<' . substitute(escape(a:str, '/\'), "\n", '\\n', 'ge') .
          \ '\>'
  endfunction

  call SubstituteRegionMakeMap("substitute-region", "s", "",
        \ "SubstitutePatternEscape", "SubstituteReplaceEscape")
  call SubstituteRegionMakeMap("substitute-region-g", "s", "g",
        \ "SubstitutePatternEscape", "SubstituteReplaceEscape")
  call SubstituteRegionMakeMap("substitute-region-c", "s", "c",
        \ "SubstitutePatternEscape", "SubstituteReplaceEscape")
  call SubstituteRegionMakeMap("subvert-region", "S", "",
        \ "SubvertPatternEscape", "SubvertReplaceEscape")
  call SubstituteRegionMakeMap("subvert-region-g", "S", "g",
        \ "SubvertPatternEscape", "SubvertReplaceEscape")
  call SubstituteRegionMakeMap("subvert-region-c", "S", "c",
        \ "SubvertPatternEscape", "SubvertReplaceEscape")

  call SubstituteRegionMakeMap("substitute-region-exact", "s", "",
        \ "SubstitutePatternEscapeExact", "SubstituteReplaceEscape")
  call SubstituteRegionMakeMap("substitute-region-g-exact", "s", "g",
        \ "SubstitutePatternEscapeExact", "SubstituteReplaceEscape")
  call SubstituteRegionMakeMap("substitute-region-c-exact", "s", "c",
        \ "SubstitutePatternEscapeExact", "SubstituteReplaceEscape")
  call SubstituteRegionMakeMap("subvert-region-exact", "S", "w",
        \ "SubvertPatternEscape", "SubvertReplaceEscape")
  call SubstituteRegionMakeMap("subvert-region-g-exact", "S", "gw",
        \ "SubvertPatternEscape", "SubvertReplaceEscape")
  call SubstituteRegionMakeMap("subvert-region-c-exact", "S", "cw",
        \ "SubvertPatternEscape", "SubvertReplaceEscape")


  call SubstituteRegionMakeMap("substitute-region-edit", "s", "",
        \ "SubstitutePatternEscape", "SubstituteReplaceEscape", 1)
  call SubstituteRegionMakeMap("subvert-region-edit", "S", "",
        \ "SubvertPatternEscape", "SubvertReplaceEscape", 1)

  function! GetVisCommand(line_dif)
    if a:line_dif
      return string(a:line_dif) . "j"
    else
      return "l"
    endif
  endfunction

  xmap <silent> <Plug>(substitute-region-visual-finish)
        \ <esc>'<<Cmd>execute "normal .".
        \ GetVisCommand(line("'>") - line("'<"))<cr>

  function! SubstituteRegionSetup(command, flags, pattern_alter, replace_alter,
        \ edit_flags)
    let g:to_sub = eval("@" . v:register)
    let g:substitute_region_start_insert = getpos("'[")
    let g:substitute_region_end_insert = getpos("']")
    let g:replace_alter = a:replace_alter
    let g:pattern_alter = a:pattern_alter
    "do nothing change required for some reason
    let cur_mode = mode()
    let is_visual = cur_mode == "v" || cur_mode == "V" || cur_mode == "\<c-v>"
    let g:substitute_region_edit_flags = a:edit_flags

    if !is_visual
      silent execute "normal! ia\<bs>\<esc>"
    endif

    let g:substitute_region_is_first = 1
    let g:substitute_region_command = a:command
    let g:substitute_region_flags = a:flags
    silent! call repeat#set("\<Plug>(operator-substitute-region)", v:count)
  endfunction

  call operator#user#define('substitute-region', 'SubstituteRegion')

  function! SubstituteRegion(_)
    let cursor = getcurpos()
    let g:substitute_region_orig_s = @s
    let start = getpos("'[")
    let end = getpos("']")
    if g:substitute_region_is_first
      if @. != ""
        call setpos("'[", g:substitute_region_start_insert)
        call setpos("']", g:substitute_region_end_insert)
        silent execute "normal! `[v`]h\"sy"
        let g:saved_s_reg = function(g:replace_alter)(@s)
        call setpos("'[", start)
        call setpos("']", end)
      else
        let g:saved_s_reg = ""
      endif
      call feedkeys("2u", 'ni')
    endif
    let @s = g:saved_s_reg
    let to_feed = "\<Cmd>call setpos(\"'[\", ". string(start) . ")\<cr>" .
          \ "\<Cmd>call setpos(\"']\", ". string(end) . ")\<cr>" .
          \ ":'[,']" .
          \ g:substitute_region_command . "/" .
          \ function(g:pattern_alter)(g:to_sub) .
          \ "/\<c-r>\<c-r>s/" .  g:substitute_region_flags

    let to_feed_suffix = " | let @s = g:substitute_region_orig_s | normal! '["
    let to_feed .= to_feed_suffix

    if g:substitute_region_edit_flags
      let to_feed .= repeat("\<left>", len(to_feed_suffix))
    else
      let to_feed .= "\<cr>"
    endif

    echom @s
    echom to_feed

    call feedkeys(to_feed, 'n')
    let g:substitute_region_is_first = 0
  endfunction

  "selection operators {{{2
  nmap ;;v  <Plug>(operator-select)
  call operator#user#define('select', 'Op_select_region')
  function! Op_select_region(motion_wiseness)
    normal! `[v`]
  endfunction

  nmap ;;<c-v>  <Plug>(operator-select-block)
  call operator#user#define('select-block', 'Op_select_block')
  function! Op_select_block(window_heightmotion_wiseness)
    exe "normal `[\<c-v>`]"
  endfunction

  nmap <a-a>  <Plug>(operator-increment-region)
  nmap <a-x>  <Plug>(operator-decrement-region)
  xmap <a-a>  <Plug>(operator-increment-region)
  xmap <a-x>  <Plug>(operator-decrement-region)
  call operator#user#define('increment-region', 'Op_increment_region')
  function! Op_increment_region(motion_wiseness)
    let start = getpos("'[")
    let end = getpos("']")
    exec ":'[,']s/\\d\\+/\\=(submatch(0)+1)/"
  endfunction
  call operator#user#define('decrement-region', 'Op_decrement_region')
  function! Op_decrement_region(motion_wiseness)
    let start = getpos("'[")
    let end = getpos("']")
    exec ":'[,']s/\\d\\+/\\=(submatch(0)-1)/"
  endfunction

  nmap <space>wa  <Plug>(operator-adjust)
  xmap <space>wa  <Plug>(operator-adjust)
  call operator#user#define('adjust', 'Op_adjust_window_height')
  function! Op_adjust_window_height(motion_wiseness)
    execute (line("']") - line("'[") + 1) 'wincmd' '_'
    normal! `[zt
  endfunction

endif

"git {{{1
nnoremap <silent> ;gs <Cmd>Gstatus<cr>
nnoremap ;gd :<c-u>Gvdiff<space>

"when bug gets fixed, switch back to builtin commands
function! GitCheckSSH(command)
  if system("cd ". expand("%:p:h") .
        \ "&& git remote show -n origin")[29:32] == "git@"
    execute "G" . a:command
  else
    execute "Git " . a:command
  endif
endfunction

nnoremap ;gp <Cmd>call GitCheckSSH("pull")<cr>
nnoremap ;gh <Cmd>call GitCheckSSH("push")<cr>

nnoremap ;gcc <Cmd>Gcommit -v<cr>
nnoremap ;gca <Cmd>Gcommit -v -a<cr>
nnoremap ;gcA <Cmd>Gcommit --amend -v -a<cr>
nnoremap ;go :<c-u>Gcheckout<space>
nnoremap ;gr :<c-u>Gremove<space>
nnoremap ;gm :<c-u>Gmove<space>

"sideways maps {{{1
nnoremap <silent> ;h <Cmd>SidewaysJumpLeft<cr>
nnoremap <silent> ;l <Cmd>SidewaysJumpRight<cr>
nnoremap <silent> ;y <Cmd>SidewaysLeft<cr>
nnoremap <silent> ;o <Cmd>SidewaysRight<cr>

"Termdebug {{{1

"visual star search and replace {{{1
xmap <space>s <Plug>(visualstar-*)``cgn
xmap <space>S <Plug>(visualstar-#)``cgN

"dispatch {{{1
nnoremap <a-m> <Cmd>Make<cr>
nnoremap <a-,> <Cmd>Make!<cr>

""vim-cmake {{{1
"nnoremap <a-b> <Cmd>CMake<cr>
"nnoremap <a-.> <Cmd>CMake!<cr>
"nnoremap <a-/> <Cmd>CMakeClean<cr>

"sandwich {{{1
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1

nmap <silent> <space>ad <Plug>(operator-sandwich-delete)
      \<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> <space>ar <Plug>(operator-sandwich-replace)
      \<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> <space>as <Plug>(operator-sandwich-delete)
      \<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nmap <silent> <space>ae <Plug>(operator-sandwich-replace)
      \<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

nmap <space>aa <Plug>(operator-sandwich-add)
xmap <space>aa <Plug>(operator-sandwich-add)
omap <space>aa <Plug>(operator-sandwich-g@)
xmap <space>ad <Plug>(operator-sandwich-delete)
xmap <space>ar <Plug>(operator-sandwich-replace)

" omap ib <Plug>(textobj-sandwich-auto-i)
" xmap ib <Plug>(textobj-sandwich-auto-i)
" omap ab <Plug>(textobj-sandwich-auto-a)
" xmap ab <Plug>(textobj-sandwich-auto-a)

" omap is <Plug>(textobj-sandwich-query-i)
" xmap is <Plug>(textobj-sandwich-query-i)
" omap as <Plug>(textobj-sandwich-query-a)
" xmap as <Plug>(textobj-sandwich-query-a)

"wintabs {{{1
nmap <a-n> <Plug>(wintabs_previous)
nmap <a-.> <Plug>(wintabs_next)
nmap <space>q <Plug>(wintabs_close)
nmap ;u <Plug>(wintabs_undo)
nmap <c-w>o <Plug>(wintabs_only)
nmap ;q <Plug>(wintabs_close_window)
nmap <c-w>O <Plug>(wintabs_only_window)
nmap <c-w>c <Plug>(wintabs_only)<Plug>(wintabs_close)
nmap <c-w>C <Plug>(wintabs_only_window)<Plug>(wintabs_only)<Plug>(wintabs_close)
nmap ;Q <Plug>(wintabs_close_vimtab)
nmap ;a <Plug>(wintabs_all)
nmap <space>.D <Cmd>WintabsDo<space>

nmap <space><space>h <Plug>(wintabs_move_to_window_left)
nmap <space><space>j <Plug>(wintabs_move_to_window_below)
nmap <space><space>k <Plug>(wintabs_move_to_window_above)
nmap <space><space>l <Plug>(wintabs_move_to_window_right)
nmap <space><space>p <Plug>(wintabs_move_to_window_next)
nmap <space><space>m <Plug>(wintabs_maximize)

nmap <space><space>q <Plug>(wintabs_tab_1)
nmap <space><space>w <Plug>(wintabs_tab_2)
nmap <space><space>e <Plug>(wintabs_tab_3)
nmap <space><space>r <Plug>(wintabs_tab_4)
nmap <space><space>t <Plug>(wintabs_tab_5)
nmap <space><space>y <Plug>(wintabs_tab_6)
nmap <space><space>u <Plug>(wintabs_tab_7)
nmap <space><space>i <Plug>(wintabs_tab_8)
nmap <space><space>o <Plug>(wintabs_tab_9)
nmap <space><space>p <Plug>(wintabs_last)

augroup CmdWinQ
  autocmd!
  autocmd CmdwinEnter * nnoremap <buffer> <space>q <Cmd>q<CR>
augroup END

"ToggleMacroMode {{{1
let s:highlighted_yank_installed = IsInstalled('machakann/vim-highlightedyank')
let s:rainbow_paren_installed = IsInstalled('luochen1990/rainbow')

function! EnterMacroMode()
  let g:clever_f_mark_cursor = 0
  let g:clever_f_mark_char = 0
  let g:qs_enable = 0
  let g:sqs_enable = 0
  let g:macro_mode= 1

  if s:highlighted_yank_installed
    HighlightedyankOff
  endif
  if s:rainbow_paren_installed
    RainbowToggleOff
  endif
  set paste
endfunction

command! -nargs=0 EnterMacroMode call EnterMacroMode()

function! ExitMacroMode()
  let g:clever_f_mark_cursor = 1
  let g:clever_f_mark_char = 1
  let g:qs_enable = 1
  let g:sqs_enable = 1
  let g:macro_mode= 0
  if s:highlighted_yank_installed
    HighlightedyankOn
  endif
  if s:rainbow_paren_installed
    RainbowToggleOn
  endif
  set nopaste
endfunction

command! -nargs=0 ExitMacroMode call ExitMacroMode()

let g:macro_mode= 0

function! ToggleMacroMode()
  if g:macro_mode == 1
    ExitMacroMode
  else
    EnterMacroMode
  endif
endfunction

command! -nargs=0 ToggleMacroMode call ToggleMacroMode()

if IsInstalled('itchyny/lightline.vim')
  noremap <silent> ;m <Cmd>ToggleMacroMode<CR><Cmd>call lightline#update()<cr>
else
  noremap <silent> ;m <Cmd>ToggleMacroMode<CR>
endif

"vim qf {{{1
nmap [q <Plug>(qf_qf_previous)
nmap ]q <Plug>(qf_qf_next)
nmap [l <Plug>(qf_loc_previous)
nmap ]l <Plug>(qf_loc_next)
nmap <c-s> <Plug>(qf_qf_switch)
nmap yoq <Plug>(qf_qf_toggle)
"overrides a unimpared mapping, but I don't use that mapping
nmap yol <Plug>(qf_loc_toggle)

"ale {{{1
nmap [a <Plug>(ale_previous_wrap)
nmap ]a <Plug>(ale_next_wrap)
nmap [A <Plug>(ale_first)
nmap ]A <Plug>(ale_last)
nmap ZA <Plug>(ale_detail)

" sneak: fFtT {{{1
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

" rooter improvements {{{1
let g:rooter_disable_first_iter = 0

function! NoRooterOneIter()
  let g:rooter_disable_first_iter = 1
  let g:rooter_manual_only = 1
endfunction

function! CheckRooterReenable()
  if g:rooter_disable_first_iter != 0
    let g:rooter_disable_first_iter = g:rooter_disable_first_iter - 1
  else
    let g:rooter_manual_only = 0
  endif
endfunction

augroup RooterReenable
  autocmd!
  autocmd BufEnter,BufReadPost,TermOpen * nested call CheckRooterReenable()
augroup END

nnoremap <silent> <space>p <Cmd>call NoRooterOneIter() <bar> lcd %:p:h<cr>
nnoremap <space>P <Cmd>call NoRooterOneIter()<cr>:<c-u>lcd<space>

" nvim-gdb {{{1
let g:nvimgdb_disable_start_keymaps = v:true

function! NvimGdbNoTKeymaps()
  tnoremap <silent> <buffer> <esc> <c-\><c-n>
endfunction

nnoremap ;dw :<c-u>call GdbCustomCommand('watchpoint set variable <c-r>=expand("<cword>")<cr>')<cr>
nnoremap ;dg :<c-u>GdbStart gdb<space>
nnoremap ;dl :<c-u>GdbStartLLDB lldb<space>
nnoremap ;dp :<c-u>:GdbStartPDB python -m pdb<space>

let g:nvimgdb_config_override = {
      \ 'key_until':      ';du',
      \ 'key_continue':   ';dc',
      \ 'key_next':       ';dn',
      \ 'key_step':       ';ds',
      \ 'key_finish':     ';df',
      \ 'key_breakpoint': ';db',
      \ 'key_frameup':    '<c-p>',
      \ 'key_framedown':  '<c-n>',
      \ 'key_eval':       ';de',
      \ 'key_quit':       ';dq',
      \ 'set_tkeymaps': 'NvimGdbNoTKeymaps',
      \ 'codewin_command': 'belowright vsplit',
      \ 'jump_bottom_gdb_buf': v:false,
      \ }

"other {{{1
nnoremap <a-i> <Cmd>Codi<cr>
nnoremap <silent> ;vh <Cmd>HexokinaseToggle<cr>
nnoremap <silent> <space>v <Cmd>call WindowSwap#EasyWindowSwap()<CR>
nmap <space>g <Plug>(git-messenger)
let g:targets_nl = 'nN'
"}}}1

" vim: set fdm=marker:
