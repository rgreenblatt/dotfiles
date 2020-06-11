"plugins list {{{1
let s:plugins = []

function! s:PA(x)
  call add(s:plugins, a:x)
endfunction

"tools for headed installs {{{2
"languages {{{2
"coc {{{3
call s:PA(['neoclide/coc.nvim', "{'branch': 'release'}"])
call s:PA(['honza/vim-snippets'])
"}}}3

"appearance {{{2
call s:PA(['gruvbox-community/gruvbox'])
call s:PA(['itchyny/lightline.vim'])
call s:PA(['machakann/vim-highlightedyank'])

"general editing {{{2
call s:PA(['wellle/targets.vim'])
" call s:PA(['rhysd/clever-f.vim'])
call s:PA(['justinmk/vim-sneak'])
call s:PA(['tommcdo/vim-exchange'])
call s:PA(['tpope/vim-repeat'])
call s:PA(['tommcdo/vim-lion'])
call s:PA(['tpope/vim-commentary'])
call s:PA(['tpope/vim-abolish'])
call s:PA(['kana/vim-textobj-user'])
call s:PA(['kana/vim-operator-user'])
call s:PA(['kana/vim-textobj-entire'])
call s:PA(['buztard/vim-rel-jump'])
call s:PA(['chaoren/vim-wordmotion'])
call s:PA(['bfredl/nvim-miniyank'])
call s:PA(['mbbill/undotree'])
call s:PA(['romainl/vim-cool'])
call s:PA(['thinca/vim-visualstar'])
call s:PA(['AndrewRadev/splitjoin.vim'])
call s:PA(['AndrewRadev/sideways.vim'])
call s:PA(['vim-scripts/ReplaceWithRegister'])
call s:PA(['stefandtw/quickfix-reflector.vim'])

"navigation/setup {{{2
call s:PA(['rgreenblatt/vim-wintabs'])
call s:PA(['junegunn/fzf', "{'dir': '~/.fzf', 'do': './install --bin'}"])
call s:PA(['rgreenblatt/fzf.vim'])
call s:PA(['wesQ3/vim-windowswap'])
call s:PA(['airblade/vim-rooter'])
call s:PA(['tpope/vim-dispatch'])
call s:PA(['radenling/vim-dispatch-neovim'])

"integrations {{{2
call s:PA(['tpope/vim-eunuch'])

"misc {{{2
call s:PA(['rgreenblatt/vim-unimpaired'])
"}}}

"add all plugins {{{1
filetype off
call plug#begin('~/.local/share/nvim/plugged')
let plugins_copy = deepcopy(s:plugins)
for plugin in plugins_copy
  let plugin[0] = "'" . plugin[0] . "'"
  execute 'Plug ' . join(plugin, ', ')
endfor
call plug#end()
filetype plugin indent on

"helpers {{{1
function! s:First(lst)
  return a:lst[0]
endfunction

let s:plugin_names = map(deepcopy(s:plugins), "s:First(v:val)")

function! IsInstalled(plugin)
  return index(s:plugin_names, a:plugin) != -1
endfunction
"}}}1

" vim: set fdm=marker:
