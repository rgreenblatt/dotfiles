"general filetype autocmds {{{1
function! RustFmtFunc() abort
  if line("$") == v:lnum + v:count - 1 && v:lnum == 1
    RustFmt
  else
    execute string(v:lnum) . "," . string(v:lnum + v:count - 1) . "RustFmtRange"
  endif
endfunction

augroup FiletypeAutocmds
  autocmd!
  if has('nvim')
    autocmd TermOpen * setlocal listchars= signcolumn=no relativenumber nonumber
          \ scrolloff=0
  endif
  autocmd Filetype tex,text,textile,mkd,markdown setlocal spell
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd BufRead,BufNewFile *.sbt set filetype=scala
  autocmd FileType,BufWrite rust setlocal formatexpr=RustFmtFunc()
augroup end

" secure modeline work around {{{1
" Since NVIM v0.4.0-464-g5eaa45547, commit 5eaa45547975c652e594d0d6dbe34c1316873dc7
" 'secure' is set when 'modeline' is set, which will cause a lot of commands
" cannot run in autocmd when opening help page.
augroup secure_modeline_conflict_workaround
  autocmd!
  autocmd FileType help setlocal nomodeline
augroup END

"mkdir as needed {{{1
function! s:MkDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkDir(expand('<afile>'), +expand('<abuf>'))
augroup end

"cursorline only in current window {{{1
function! EnterWin()
  set cursorline
endfunction

function! ExitWin()
  set nocursorline
endfunction

augroup BgHighlight
  autocmd!
  autocmd WinEnter,TabEnter,BufWinEnter * call EnterWin()
  autocmd WinLeave,TabLeave  * call ExitWin()
augroup END

"clean up no names {{{1
function! CleanNoNameEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && '.
        \ 'empty(bufname(v:val)) && bufwinnr(v:val) < 0 && ' .
        \ '(getbufline(v:val, 1, "$") == [""])')
  if !empty(buffers)
    exe 'bd '.join(buffers, ' ')
  endif
endfunction

augroup CleanBuffers
  autocmd!
  autocmd BufLeave * call CleanNoNameEmptyBuffers()
augroup END
"}}}1
" vim: set fdm=marker:
