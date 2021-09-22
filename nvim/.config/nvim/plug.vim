"setplugin_blacklist up blacklist {{{1
if !exists("g:plugin_blacklist")
  let g:plugin_blacklist = {}
endif

if g:athame_running
  let g:plugin_blacklist.athame = [
        \ 'unblevable/quick-scope',
        \ 'markonm/traces.vim',
        \ ]
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

"tools for headed installs {{{2
if !g:headless
  call s:PA(['rgreenblatt/xdg_open.vim'])
endif

"languages {{{2
if !g:no_language_plugins
  "coc {{{3
  if !g:no_coc
    call s:PA(['neoclide/coc.nvim', "{'branch': 'release'}"])
    call s:PA(['liuchengxu/vista.vim'])
    call s:PA(['honza/vim-snippets'])
  endif
  "}}}3

  " call s:PA(['jackguo380/vim-lsp-cxx-highlight'])
  call s:PA(['ziglang/zig.vim'])
  call s:PA(['dense-analysis/ale'])
  call s:PA(['maximbaz/lightline-ale'])
  call s:PA(['lervag/vimtex'])
  call s:PA(['KeitaNakamura/tex-conceal.vim'])
  call s:PA(['ludovicchabant/vim-gutentags'])
  call s:PA(['Chiel92/vim-autoformat'])
  call s:PA(['tpope/vim-apathy'])
  call s:PA(['kana/vim-textobj-function'])
  call s:PA(['sheerun/vim-polyglot'])
  call s:PA(['tpope/vim-markdown'])
  call s:PA(['Julian/lean-unicode.vim'])
  call s:PA(['Julian/lean.nvim'])
  call s:PA(['neovim/nvim-lspconfig'])
  call s:PA(['nvim-lua/plenary.nvim'])
endif

"appearance {{{2
if !g:no_appearance_plugins
  call s:PA(['gruvbox-community/gruvbox'])
  " We recommend updating the parsers on update
  if !g:no_treesitter
    call s:PA(['nvim-treesitter/nvim-treesitter', "{'do': ':TSUpdate'}"])
  endif
  call s:PA(['itchyny/lightline.vim'])
  call s:PA(['machakann/vim-highlightedyank'])
  call s:PA(['RRethy/vim-hexokinase', "{'do': 'make hexokinase'}"])
endif

"general editing {{{2
if !g:no_editing_plugins
  call s:PA(['wellle/targets.vim'])
  call s:PA(['unblevable/quick-scope'])
  call s:PA(['justinmk/vim-sneak'])
  call s:PA(['inkarkat/vim-ingo-library'])
  call s:PA(['inkarkat/vim-CountJump'])
  call s:PA(['inkarkat/vim-EnhancedJumps'])
  call s:PA(['markonm/traces.vim'])
  call s:PA(['tommcdo/vim-exchange'])
  call s:PA(['tpope/vim-repeat'])
  call s:PA(['tommcdo/vim-lion'])
  call s:PA(['tpope/vim-commentary'])
  call s:PA(['tpope/vim-abolish'])
  call s:PA(['michaeljsmith/vim-indent-object'])
  call s:PA(['kana/vim-textobj-user'])
  call s:PA(['kana/vim-textobj-fold'])
  call s:PA(['kana/vim-operator-user'])
  call s:PA(['kana/vim-textobj-entire'])
  call s:PA(['buztard/vim-rel-jump'])
  call s:PA(['chaoren/vim-wordmotion'])
  call s:PA(['bfredl/nvim-miniyank'])
  call s:PA(['kshenoy/vim-signature'])
  call s:PA(['mbbill/undotree'])
  call s:PA(['romainl/vim-cool'])
  call s:PA(['wsdjeg/vim-fetch'])
  call s:PA(['thinca/vim-visualstar'])
  call s:PA(['AndrewRadev/splitjoin.vim'])
  call s:PA(['AndrewRadev/sideways.vim'])
  call s:PA(['vim-scripts/ReplaceWithRegister'])
  call s:PA(['stefandtw/quickfix-reflector.vim'])
  if !g:no_treesitter
    call s:PA(['nvim-treesitter/nvim-treesitter-textobjects'])
  endif
endif

"navigation/setup {{{2
if !no_setup_plugins
  call s:PA(['mhinz/vim-startify'])
  call s:PA(['rgreenblatt/vim-wintabs'])
  call s:PA(['junegunn/fzf', "{'dir': '~/.fzf', 'do': './install --bin'}"])
  call s:PA(['rgreenblatt/fzf.vim'])
  call s:PA(['wesQ3/vim-windowswap'])
  call s:PA(['justinmk/vim-dirvish'])
  call s:PA(['kristijanhusak/vim-dirvish-git'])
  call s:PA(['embear/vim-localvimrc'])
  call s:PA(['airblade/vim-rooter'])
  call s:PA(['tpope/vim-dispatch'])
  call s:PA(['radenling/vim-dispatch-neovim'])
  call s:PA(['skywind3000/asyncrun.vim'])
endif

"integrations {{{2
if !g:no_integration_plugins
  call s:PA(['makerj/vim-pdf'])
  call s:PA(['tpope/vim-fugitive'])
  call s:PA(['tpope/vim-rhubarb'])
  call s:PA(['junegunn/gv.vim'])
  call s:PA(['rhysd/git-messenger.vim'])
  call s:PA(['tpope/vim-eunuch'])
  call s:PA(['lambdalisue/suda.vim'])
  call s:PA(['sakhnik/nvim-gdb', "{ 'do': ':!./install.sh' }"])
endif

"misc {{{2
if !g:no_misc_plugins
  call s:PA(['rgreenblatt/vim-unimpaired'])
  "TODO
  " call s:PA(['zenbro/mirror.vim'])
endif
"}}}

"add all plugins {{{1
filetype off
if g:disable_all_plugins
  let s:plugins = []
else
  call plug#begin('~/.local/share/nvim/plugged')
  let plugins_copy = deepcopy(s:plugins)
  for plugin in plugins_copy
    if index(g:combined_blacklist, plugin[0]) == -1
      let plugin[0] = "'" . plugin[0] . "'"
      execute 'Plug ' . join(plugin, ', ')
    endif
  endfor
  call plug#end()
endif
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
