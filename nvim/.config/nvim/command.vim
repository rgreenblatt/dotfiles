"command for getting the output of another command {{{1
function! s:Output(cmd)
    redir => message
    silent execute a:cmd
    redir END
    if empty(message)
        echoerr "no output"
    else
        new
        setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
        silent put=message
    endif
endfunction

command! -nargs=+ -complete=command Output call s:Output(<q-args>)

"command for setting gdb path {{{1
function! s:SetDebugPath(path)
    let g:debug_path = a:path
endfunction

command! -nargs=1 -complete=shellcmd SetDebugPath call s:SetDebugPath(<q-args>)

"terminals {{{1
let g:shared_term_buffer = -1

function! s:GlobalSharedTerm()
  if g:shared_term_buffer > 0
    execute 'buffer ' . g:shared_term_buffer
  else
    execute 'terminal'
    let g:shared_term_buffer = bufnr('%')
    autocmd BufWipeout <buffer> let g:shared_term_buffer = -1
  endif
endfunction

command! -nargs=0 GlobalSharedTerm call s:GlobalSharedTerm()

"timing commands {{{1
" Times the number of times a particular command takes to execute the
" specified number of times (in seconds).
function! HowLong( command, numberOfTimes )
  " We don't want to be prompted by a message if the command being tried is
  " an echo as that would slow things down while waiting for user input.
  let more = &more
  set nomore
  let startTime = localtime()
  for i in range( a:numberOfTimes )
    execute a:command
  endfor
  let result = localtime() - startTime
  let &more = more
  echo result
  return result
endfunction
"}}}1

" vim: set fdm=marker:
