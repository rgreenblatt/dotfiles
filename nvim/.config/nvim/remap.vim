"remaps which override defaults {{{1
map Y y$

noremap , "
noremap " ,

noremap ,m "_
noremap ,j "+

map <space> <leader>
map <space><space> <leader><leader>

noremap <BS> -
nnoremap z<BS> z-

nnoremap U <C-r>

nnoremap "a 1gt
nnoremap "s 2gt
nnoremap "d 3gt
nnoremap "f 4gt
nnoremap "g 5gt
nnoremap "h 6gt
nnoremap "j 7gt
nnoremap "k 8gt
nnoremap "l 9gt
nnoremap "; <Cmd>tablast<cr>

for first in ['', 'g', '[', ']']
    for mode in ['n', 'x', 'o']
        exe mode . "noremap " . first . "' " . first . "`"
        exe mode . "noremap " . first . "` " . first . "'"
    endfor
endfor

"macros {{{1
xnoremap @ :<c-u>call ExecuteMacroOverVisualRange()<cr>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal!  @".nr2char(getchar())
endfunction

" repeatable macros {{{2
" When . repeats g@, repeat the last macro.
function! AtRepeat(_)
    " If no count is supplied use the one saved in s:atcount.
    " Otherwise save the new count in s:atcount, so it will be
    " applied to repeats.
    let s:atcount = v:count ? v:count : s:atcount
    " feedkeys() rather than :normal allows finishing in Insert
    " mode, should the macro do that. @@ is remapped, so 'opfunc'
    " will be correct, even if the macro changes it.
    call feedkeys(s:atcount.'@@')
endfunction

function! AtSetRepeat(_)
    set opfunc=AtRepeat
endfunction

" Called by g@ being invoked directly for the first time. Sets
" 'opfunc' ready for repeats with . by calling AtSetRepeat().
function! AtInit()
    " Make sure setting 'opfunc' happens here, after initial playback
    " of the macro recording, in case 'opfunc' is set there.
    set opfunc=AtSetRepeat
    return 'g@l'
endfunction

" Enable calling a function within the mapping for @
nnoremap <expr> <plug>@init AtInit()
" A macro could, albeit unusually, end in Insert mode.
inoremap <expr> <plug>@init "\<c-o>".AtInit()
xnoremap <expr> <plug>@init AtInit()

function! AtReg()
    let s:atcount = v:count1
    let c = nr2char(getchar())
    return '@'.c."\<plug>@init"
endfunction

nmap <expr> @ AtReg()

function! QRepeat(_)
    call feedkeys('@'.s:qreg)
endfunction

function! QSetRepeat(_)
    set opfunc=QRepeat
endfunction

function! QStop()
    set opfunc=QSetRepeat
    return 'g@l'
endfunction

nnoremap <expr> <plug>qstop QStop()
inoremap <expr> <plug>qstop "\<c-o>".QStop()

let s:qrec = 0
function! QStart()
    if s:qrec == 1
        let s:qrec = 0
        return "q\<plug>qstop"
    endif
    let s:qreg = nr2char(getchar())
    if s:qreg =~# '[0-9a-zA-Z"]'
        let s:qrec = 1
    endif
    return 'q'.s:qreg
endfunction

nmap <expr> q QStart()

"conceal toggle {{{1
nnoremap ;vc :<c-u>set <C-R>=&conceallevel ?
      \ 'conceallevel=0' : 'conceallevel=2'<cr><cr>

"command mode navigation{{{1
cnoremap <C-A> <Home>

"fix spelling mistake {{{1
inoremap <c-f> <c-g>u<Esc>[s1z=`]a<c-g>u

function! FixSpellingMistake() abort
  let orig_spell_pos = getcurpos()
  normal! [s1z=
  call setpos('.', orig_spell_pos)
endfunction

nnoremap <c-f> <Cmd>call FixSpellingMistake()<cr>

"window maps {{{1
function! FloatingFullscreen()
  let buf = bufnr('%')
  "full size
  let height = &lines - 1 - &cmdheight
  let width = &columns

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 0,
        \ 'col': 0,
        \ 'width': width,
        \ 'height': height
        \ }

  " not sure why before and after is required
  set winhighlight=NormalFloat:Normal
  let win_id = nvim_open_win(buf, v:true, opts)
  set winhighlight=NormalFloat:Normal

  return win_id
endfunction

let g:window_key_prefix = "<space>"
" the first value is the key and the second is the new window command
let g:window_key_mappings = [
            \ ["h", "aboveleft vsplit"],
            \ ["j", "belowright split"],
            \ ["k", "aboveleft split"],
            \ ["l", "belowright vsplit"],
            \ [";", "call FloatingFullscreen()"],
            \ [",", 
            \ "let buf = bufnr('%') <bar> tabnew <bar> execute 'buffer' buf"],
            \ [".", ""],
            \ ["H", "topleft vsplit"],
            \ ["J", "botright split"],
            \ ["K", "topleft split"],
            \ ["L", "botright vsplit"],
            \ ]

" Create an additional set of window maps for some command.
" If user_enter is truthy (typically 1), then the command won't be automatically
" executed; the user will have to press enter. This is useful for commands
" which require user input (edit for example).
function! MapWinCmd(key, command, user_enter)
  if a:user_enter
    let suffix = ""
  else
    let suffix = "<cr>"
  endif

  for key_mapping in g:window_key_mappings
      execute "nnoremap " . g:window_key_prefix . key_mapping[0] . a:key . 
                  \ " <Cmd>" . key_mapping[1] . "<cr>:<c-u>" . a:command .
                  \ suffix
  endfor
endfunction

"new window: edit, scratch, and current {{{1
call MapWinCmd("e", "e ", 1)
call MapWinCmd("w", "enew <bar> setlocal bufhidden=hide nobuflisted " .
      \ "buftype=nofile", 0)
call MapWinCmd("c", "", 0)

"tab for prev position {{{1
nnoremap <tab> <c-o>
nnoremap <s-tab> <c-i>

"general space/semicolon/alt maps {{{1
nnoremap <silent> <space>p <Cmd>lcd %:p:h<cr>
nnoremap <space>P :<c-u>lcd<space>
nnoremap <space>; <Cmd>let @@=expand("%")<cr>
nnoremap <space>: <Cmd>let @@=expand("%:p")<cr>

nnoremap <space>y <Cmd>let @+=@@<cr>
nnoremap <space>Y :<c-u>let @+=@

nnoremap <silent> <a-n> <Cmd>set invrelativenumber<cr>
nnoremap <silent> <a-w> <Cmd>%s/\s\+$//<cr>:let @/=''<cr>

nnoremap <A-l> <c-w>l
nnoremap <A-k> <c-w>k
nnoremap <A-j> <c-w>j
nnoremap <A-h> <c-w>h

nnoremap <silent> <space>q <Cmd>q<cr>
nnoremap <silent> <space>A <Cmd>qa<cr>
nnoremap <silent> <space>b <Cmd>w<cr>
nnoremap <silent> <a-d> <Cmd>bd!<cr>

xnoremap ;i :'<,'>normal ^i
xnoremap ;a :'<,'>normal $a

nnoremap <space>ww <C-w><bar>
nnoremap <space>wt <C-w>_
nnoremap <space>we <C-w>=
nnoremap <space>wm <C-w><bar><C-w>_
nmap <space>w <C-w>

xnoremap <space>t <C-]>
xnoremap <space>T <C-T>
xnoremap ;t g<C-]>

nnoremap <space>t <C-]>
nnoremap <space>T <C-T>
nnoremap ;t g<C-]>

nnoremap <space>s *``cgn
nnoremap <space>S #``cgN

nnoremap <space>Q <Cmd>bp\|bd! #<cr>

map <Plug>(FormatSelected) gq
map <Plug>(FormatAll) gggqG

nmap <space>f <Plug>(FormatSelected)
xmap <space>f <Plug>(FormatSelected)

nmap <space>F <Plug>(FormatAll)

nnoremap <a-p> <Cmd>pwd<cr>
nnoremap <a-s> <Cmd>source %<cr>

nnoremap <space>z :<c-u>s/\C<left><left><left><left>
xnoremap <space>z :s/\C

"better cmd line {{{1
cnoremap <esc> <c-f>z1<cr>

augroup CmdWin
  autocmd!
  autocmd CmdwinEnter * cnoremap <buffer> <esc> <C-c>
  autocmd CmdwinEnter * nnoremap <esc> <C-c><C-c>
  autocmd CmdwinEnter * nnoremap <expr><buffer><silent> k
        \ 'kz7<cr>:nnoremap k k<cr>'
  autocmd CmdwinEnter * au InsertEnter <buffer> :call feedkeys("\<C-c>")
  autocmd CmdwinEnter * set cmdheight=1
  autocmd CmdwinLeave * set cmdheight=3
augroup END

"terminal {{{1
if has("nvim")
  tnoremap <C-Space> <C-\><C-n>
endif

call MapWinCmd("t", "terminal", 0)
call MapWinCmd("T", "GlobalSharedTerm", 0)

"arrow key window resize {{{1
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W>>
noremap <right> 3<C-W><

"select last selectinserted/yank/etc text {{{1
nnoremap gV `[v`]

"remove function {{{1
nnoremap ;x %%mv%x`vvbd


"fold {{{1
nnoremap zJ zczjzo
nnoremap zK zczkzo

"no ctrl z, I don't typically use vim in a shell, I run it standalone {{{1
nnoremap <c-z> <nop>
"}}}

" vim: set fdm=marker:
