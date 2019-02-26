"TODO:
"marks (also vim-mark) - nice af
"folds - nice af
"vim fugitive - nice af
"coc - great, but sometimes buggy
"surround - learning
"vim lion - still working on it, but good
"ex type commands - ***
"fzf - not sold yet
"so much....

set nocompatible
filetype off
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dansomething/vim-eclim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'rust-lang/rust.vim'
Plug 'wikitopian/hardmode'
Plug 'inkarkat/vim-CountJump'
Plug 'wellle/targets.vim'
Plug 'wellle/line-targets.vim'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'itchyny/lightline.vim'
Plug 'rgreenblatt/i3-vim-focus'
Plug 'markonm/traces.vim'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'
Plug 'makerj/vim-pdf'
Plug 'vim-scripts/repeatable-motions.vim'
Plug 'unblevable/quick-scope'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'TaDaa/vimade'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/clever-f.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'rjayatilleka/vim-insert-char'
Plug 'mhinz/vim-startify'
call plug#end()
filetype plugin indent on

"---basic quality of life---
set relativenumber
set number
set undofile

"large registers
set viminfo='19,<1000,s1000

"tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

highlight TermCursor ctermfg=red guifg=red

set wildmode=longest,list,full
set wildmenu

"highlight column 110 to avoid going to long
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

"https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

au FocusLost * :wa

"java specific tab settings
autocmd Filetype java setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=80

"auto indent for tex is garbage
autocmd Filetype tex setlocal indentexpr=
"autocmd Filetype tex call CountJump#TextObject#MakeWithCountSearch('<buffer>', '$', 'ai', 'v', '\$', '\$')

autocmd FileType json syntax match Comment +\/\/.\+$+

"---remaps---
inoremap kj <esc>
inoremap jk <esc>

"term esc
tnoremap <A-n> <C-\><C-n>

"general alt key maps
noremap <silent> <A-l> <esc>:call Focus('right', 'l')<CR>
noremap <silent> <A-h> <esc>:call Focus('left', 'h')<CR>
noremap <silent> <A-k> <esc>:call Focus('up', 'k')<CR>
noremap <silent> <A-j> <esc>:call Focus('down', 'j')<CR>

noremap <silent> <A-m>t :tabe term://bash<CR>
noremap <silent> <A-,>t :sp term://bash<CR>
noremap <silent> <A-.>t :vs term://bash<CR>

noremap <silent> <A-m>s :tabe<CR>:Startify<CR>
noremap <silent> <A-,>s :sp<CR>:Startify<CR>
noremap <silent> <A-.>s :vs<CR>:Startify<CR>

noremap <silent> <A-/> :cd %:p:h<CR>

noremap <silent> <A-z> :noh<CR>

noremap! <silent> <A-l> <esc>:call Focus('right', 'l')<CR>
noremap! <silent> <A-h> <esc>:call Focus('left', 'h')<CR>
noremap! <silent> <A-k> <esc>:call Focus('up', 'k')<CR>
noremap! <silent> <A-j> <esc>:call Focus('down', 'j')<CR>

noremap! <silent> <A-m>t <esc>:tabe term://bash<CR>
noremap! <silent> <A-,>t <esc>:sp term://bash<CR>
noremap! <silent> <A-.>t <esc>:vs term://bash<CR>

noremap! <silent> <A-m>s <esc>:tabe<CR>:Startify<CR>
noremap! <silent> <A-,>s <esc>:sp<CR>:Startify<CR>
noremap! <silent> <A-.>s <esc>:vs<CR>:Startify<CR>

noremap! <silent> <A-/> <esc>:cd %:p:h<CR>i

noremap! <silent> <A-z> <esc>:noh<CR>i


tnoremap <silent> <A-l> <C-\><C-n>:call Focus('right', 'l')<CR>
tnoremap <silent> <A-h> <C-\><C-n>:call Focus('left', 'h')<CR>
tnoremap <silent> <A-k> <C-\><C-n>:call Focus('up', 'k')<CR>
tnoremap <silent> <A-j> <C-\><C-n>:call Focus('down', 'j')<CR>

tnoremap <silent> <A-m>t <C-\><C-n>:tabe term://bash<CR>
tnoremap <silent> <A-,>t <C-\><C-n>:sp term://bash<CR>
tnoremap <silent> <A-.>t <C-\><C-n>:vs term://bash<CR>

tnoremap <silent> <A-m>s <C-\><C-n>:tabe<CR>:Startify<CR>
tnoremap <silent> <A-,>s <C-\><C-n>:sp<CR>:Startify<CR>
tnoremap <silent> <A-.>s <C-\><C-n>:vs<CR>:Startify<CR>

tnoremap <silent> <A-/> <C-\><C-n>:cd %:p:h<CR>i

tnoremap <silent> <A-z> <C-\><C-n>:noh<CR>i


"completion
inoremap <A-p> <C-x><C-u>

"remap f keys
noremap <F4> <C-w>_
noremap <F5> <C-w><bar>
noremap <F6> <C-w>=

" Go to last active tab
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap <silent> <A-Tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use `[c` and `]c` for navigate diagnostics
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)

"change leader
map <space> \

" Remap keys for gotos
nmap <leader>d <Plug>(coc-definition)
nmap <leader>t <Plug>(coc-type-definition)
nmap <leader>i <Plug>(coc-implementation)
nmap <leader>u <Plug>(coc-references)

"java doc commenting
noremap <silent> <leader>c <esc>:JavaDocComment<CR>

noremap <silent> <leader>w :%s/\s\+$//<cr>:let @/=''<CR>

"show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"---misc---
"lightline config
let g:lightline = {
      \ 'colorscheme': 'srcery_drk',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'gitstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitstatus': 'FugitiveStatusline'
      \ }
      \ }

"open git locally
let $GIT_EDITOR = 'nvr -cc split --remote-wait'
autocmd FileType gitcommit set bufhidden=delete

"do I need this
set guicursor=

let b:lion_squeeze_spaces = 1

let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms = 3000

let g:insert_char_no_default_mapping = 1
nmap ; <Plug>InsertChar
    
let g:startify_bookmarks = [{'B': '~/.bashrc'}, {'v': '~/.config/nvim/init.vim'},
      \ {'w': '~/.config/i3/config'}, {'t': 'term://bash'}]
let g:startify_custom_header = []
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ { 'type': 'files',     'header': ['   Recent']            },
      \ { 'type': 'dir',       'header': ['   Recent: '. getcwd()] },
      \ ]
