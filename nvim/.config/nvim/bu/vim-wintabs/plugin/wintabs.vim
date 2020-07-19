if exists('g:loaded_wintabs') || v:version < 700
  finish
endif
let g:loaded_wintabs = 1

" key mappings
nnoremap <silent> <Plug>(wintabs_next) :<C-U>WintabsNext<CR>
nnoremap <silent> <Plug>(wintabs_previous) :<C-U>WintabsPrevious<CR>
nnoremap <silent> <Plug>(wintabs_close) :<C-U>WintabsClose<CR>
nnoremap <silent> <Plug>(wintabs_undo) :<C-U>WintabsUndo<CR>
nnoremap <silent> <Plug>(wintabs_only) :<C-U>WintabsOnly<CR>
nnoremap <silent> <Plug>(wintabs_all) :<C-U>WintabsAll<CR>
nnoremap <silent> <Plug>(wintabs_close_window) :<C-U>WintabsCloseWindow<CR>
nnoremap <silent> <Plug>(wintabs_only_window) :<C-U>WintabsOnlyWindow<CR>
nnoremap <silent> <Plug>(wintabs_close_vimtab) :<C-U>WintabsCloseVimtab<CR>
nnoremap <silent> <Plug>(wintabs_only_vimtab) :<C-U>WintabsOnlyVimtab<CR>
nnoremap <silent> <Plug>(wintabs_tab_1) :<C-U>WintabsGo 1<CR>
nnoremap <silent> <Plug>(wintabs_tab_2) :<C-U>WintabsGo 2<CR>
nnoremap <silent> <Plug>(wintabs_tab_3) :<C-U>WintabsGo 3<CR>
nnoremap <silent> <Plug>(wintabs_tab_4) :<C-U>WintabsGo 4<CR>
nnoremap <silent> <Plug>(wintabs_tab_5) :<C-U>WintabsGo 5<CR>
nnoremap <silent> <Plug>(wintabs_tab_6) :<C-U>WintabsGo 6<CR>
nnoremap <silent> <Plug>(wintabs_tab_7) :<C-U>WintabsGo 7<CR>
nnoremap <silent> <Plug>(wintabs_tab_8) :<C-U>WintabsGo 8<CR>
nnoremap <silent> <Plug>(wintabs_tab_9) :<C-U>WintabsGo 9<CR>
nnoremap <silent> <Plug>(wintabs_first) :<C-U>WintabsFirst<CR>
nnoremap <silent> <Plug>(wintabs_last) :<C-U>WintabsLast<CR>
nnoremap <silent> <Plug>(wintabs_move_left) :<C-U>WintabsMove -1<CR>
nnoremap <silent> <Plug>(wintabs_move_right) :<C-U>WintabsMove 1<CR>
nnoremap <silent> <Plug>(wintabs_move_to_window_left) :<C-U>WintabsMoveToWindow h<CR>
nnoremap <silent> <Plug>(wintabs_move_to_window_right) :<C-U>WintabsMoveToWindow l<CR>
nnoremap <silent> <Plug>(wintabs_move_to_window_above) :<C-U>WintabsMoveToWindow k<CR>
nnoremap <silent> <Plug>(wintabs_move_to_window_below) :<C-U>WintabsMoveToWindow j<CR>
nnoremap <silent> <Plug>(wintabs_move_to_window_next) :<C-U>WintabsMoveToWindow w<CR>
nnoremap <silent> <Plug>(wintabs_maximize) :<C-U>WintabsMaximize<CR>
nnoremap <silent> <Plug>(wintabs_refresh) :<C-U>WintabsRefresh<CR>

" commands
command! WintabsNext call wintabs#jump(1)
command! WintabsPrevious call wintabs#jump(-1)
command! WintabsClose call wintabs#close()
command! WintabsUndo call wintabs#undo()
command! WintabsOnly call wintabs#only()
command! WintabsAll call wintabs#all()
command! WintabsAllBuffers call wintabs#all_buffers()
command! WintabsCloseWindow call wintabs#close_window()
command! WintabsOnlyWindow call wintabs#only_window()
command! WintabsCloseVimtab call wintabs#close_vimtab()
command! WintabsOnlyVimtab call wintabs#only_vimtab()
command! -nargs=1 WintabsGo call wintabs#go(<q-args> + 0)
command! WintabsFirst call wintabs#go(1)
command! WintabsLast call wintabs#go(-1)
command! -nargs=1 WintabsMove call wintabs#move(<q-args> + 0)
command! -nargs=1 WintabsMoveToWindow call wintabs#move_to_window(<q-args>)
command! WintabsMaximize call wintabs#maximize()
command! -nargs=1 WintabsDo call wintabs#do(<q-args>)
command! WintabsRefresh call wintabs#init()

" configurations
function! s:set(var, value)
  if !exists(a:var)
    let {a:var} = a:value
  endif
endfunction

" major
call s:set('g:wintabs_autoclose', 1)
call s:set('g:wintabs_autoclose_vim', 0)
call s:set('g:wintabs_autoclose_vimtab', 0)
call s:set('g:wintabs_autoclose_vimtab', 0)
call s:set('g:wintabs_switchbuf', &switchbuf)
call s:set('g:wintabs_delete_buffers', 0)
call s:set('g:wintabs_buffer_limit', 0)
call s:set('g:wintabs_ignored_filetypes', ['gitcommit', 'vundle', 'qf',
      \ 'vimfiler'])

call s:set('g:wintabs_reverse_order', 0)
call s:set('g:wintabs_undo_limit', 100)
call s:set('g:wintabs_marker_modified', "!")
call s:set('g:wintabs_marker_current', "*")
call s:set('g:wintabs_separator', " ")
call s:set('g:wintabs_only_basename', 1)
call s:set('g:wintabs_show_number', 0)
call s:set('g:wintabs_not_current_character_limit', 0)
call s:set('g:wintabs_marker_cutoff', "…")

" init session
call wintabs#session#init()

" init undo list
call wintabs#undo#init()

" start wintabs
call wintabs#init()
