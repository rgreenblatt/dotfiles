"setplugin_blacklist up blacklist {{{1
if !exists("g:plugin_blacklist")
  let g:plugin_blacklist = {}
endif

let g:combined_blacklist = []
for val in values(g:plugin_blacklist)
  let g:combined_blacklist += val
endfor

"plugins list {{{1
let s:plugins = []

function! s:PA(x)
  call add(s:plugins, a:x)
endfunction

"navigation/setup {{{2
if !no_setup_plugins
  call s:PA(['junegunn/fzf', "{'dir': '~/.fzf', 'do': './install --bin'}"])
  call s:PA(['rgreenblatt/fzf.vim'])
endif
"}}}

"add all plugins {{{1
filetype off
" if g:disable_all_plugins
let s:plugins = []
" else
"   call plug#begin('~/.local/share/nvim/plugged')
"   let plugins_copy = deepcopy(s:plugins)
"   for plugin in plugins_copy
"     if index(g:combined_blacklist, plugin[0]) == -1
"       let plugin[0] = "'" . plugin[0] . "'"
"       execute 'Plug ' . join(plugin, ', ')
"     endif
"   endfor
"   call plug#end()
" endif
filetype plugin indent on

"helpers {{{1
function! s:First(lst)
  return a:lst[0]
endfunction

let s:plugin_names = map(deepcopy(s:plugins), "s:First(v:val)")

function! IsInstalled(plugin)
  return index(s:plugin_names, a:plugin) != -1 && 
        \ index(g:combined_blacklist, a:plugin) == -1
endfunction
"}}}1

" vim: set fdm=marker:
