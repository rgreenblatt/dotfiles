"serious changes or remaps:
map Y y$

map <leader>j ]
map <leader>k [

"clever-f

inoremap kj <esc>
inoremap jk <esc>

noremap ,m "_
vnoremap ,m "_

noremap ,j "+
vnoremap ,j "+

map , "

map <space> <leader>

"plugins
set nocompatible
filetype off
call plug#begin('~/.local/share/nvim/plugged')
" Plug 'dansomething/vim-eclim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'rust-lang/rust.vim'
Plug 'wikitopian/hardmode'
Plug 'inkarkat/vim-CountJump'
Plug 'wellle/targets.vim'
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
Plug 'rgreenblatt/vim-insert-char'
Plug 'mhinz/vim-startify'
Plug 'wesQ3/vim-windowswap'
Plug 'vim-scripts/restore_view.vim'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'rgreenblatt/scratch.vim'
Plug 'rgreenblatt/vim-ninja-feet'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'
Plug 'flazz/vim-colorschemes'
call plug#end()
filetype plugin indent on

"number settings
set relativenumber
set number

"view settings
set undofile
set viewoptions=cursor,folds,slash,unix

"large registers
set viminfo='19,<1000,s1000

"tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"red terminal cursor
highlight TermCursor ctermfg=red guifg=red

"better menu tab completion
set wildmode=longest,list,full
set wildmenu

"highlight column 110 to avoid going to long
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

"mkdir as needed https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
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

autocmd Filetype java setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=80

"auto indent for tex is garbage
autocmd Filetype tex setlocal indentexpr=

autocmd FileType json syntax match Comment +\/\/.\+$+

"command mode navigation
cnoremap <C-A> <Home>

"alt key maps
noremap <silent> <A-l> <esc>:call Focus('right', 'l')<CR>
noremap <silent> <A-h> <esc>:call Focus('left', 'h')<CR>
noremap <silent> <A-k> <esc>:call Focus('up', 'k')<CR>
noremap <silent> <A-j> <esc>:call Focus('down', 'j')<CR>

noremap <silent> <A-m>t :tabe term://bash<CR>
noremap <silent> <A-,>t :sp term://bash<CR>
noremap <silent> <A-.>t :vs term://bash<CR>
noremap <silent> <A-/>t :te<CR>

noremap <silent> <A-m>s :tabe<CR>:Startify<CR>
noremap <silent> <A-,>s :sp<CR>:Startify<CR>
noremap <silent> <A-.>s :vs<CR>:Startify<CR>
noremap <silent> <A-/>s :Startify<CR>

noremap <silent> <A-m>f :tabe %<CR>
noremap <silent> <A-,>f :sp<CR>
noremap <silent> <A-.>f :vs<CR>

noremap <silent> <A-t> :cd %:p:h<CR>

noremap <silent> <A-g>m <C-w>_<C-w><bar>
noremap <silent> <A-g>e <C-w>=

noremap <silent> <A-g>n :set number<CR>:set norelativenumber<CR>
noremap <silent> <A-g>r :set number<CR>:set relativenumber<CR>

noremap <silent> <A-z> :noh<CR>

noremap! <silent> <A-l> <esc>:call Focus('right', 'l')<CR>
noremap! <silent> <A-h> <esc>:call Focus('left', 'h')<CR>
noremap! <silent> <A-k> <esc>:call Focus('up', 'k')<CR>
noremap! <silent> <A-j> <esc>:call Focus('down', 'j')<CR>

noremap! <silent> <A-m>t <esc>:tabe term://bash<CR>
noremap! <silent> <A-,>t <esc>:sp term://bash<CR>
noremap! <silent> <A-.>t <esc>:vs term://bash<CR>
noremap! <silent> <A-/>t <esc>:te<CR>

noremap! <silent> <A-m>f <esc>:tabe %<CR>
noremap! <silent> <A-,>f <esc>:sp <CR>
noremap! <silent> <A-.>f <esc>:vs <CR>

noremap! <silent> <A-m>s <esc>:tabe<CR>:Startify<CR>
noremap! <silent> <A-,>s <esc>:sp<CR>:Startify<CR>
noremap! <silent> <A-.>s <esc>:vs<CR>:Startify<CR>
noremap! <silent> <A-/>s <esc>:Startify<CR>

noremap! <silent> <A-t> <esc>:cd %:p:h<CR>a

noremap! <silent> <A-z> <esc>:noh<CR>a

noremap! <silent> <A-g>m  <esc><C-w>_<C-w><bar>
noremap! <silent> <A-g>e  <esc><C-w>=

noremap! <silent> <A-g>n <esc>:set number<CR>:set norelativenumber<CR>a
noremap! <silent> <A-g>r <esc>:set number<CR>:set relativenumber<CR>a

tnoremap <silent> <A-l> <C-\><C-n>:call Focus('right', 'l')<CR>
tnoremap <silent> <A-h> <C-\><C-n>:call Focus('left', 'h')<CR>
tnoremap <silent> <A-k> <C-\><C-n>:call Focus('up', 'k')<CR>
tnoremap <silent> <A-j> <C-\><C-n>:call Focus('down', 'j')<CR>

tnoremap <silent> <A-m>t <C-\><C-n>:tabe term://bash<CR>
tnoremap <silent> <A-,>t <C-\><C-n>:sp term://bash<CR>
tnoremap <silent> <A-.>t <C-\><C-n>:vs term://bash<CR>
tnoremap <silent> <A-/>t <C-\><C-n>:te<CR>

tnoremap <silent> <A-m>s <C-\><C-n>:tabe<CR>:Startify<CR>
tnoremap <silent> <A-,>s <C-\><C-n>:sp<CR>:Startify<CR>
tnoremap <silent> <A-.>s <C-\><C-n>:vs<CR>:Startify<CR>
tnoremap <silent> <A-/>s <C-\><C-n>:Startify<CR>

tnoremap <silent> <A-m>f <C-\><C-n>:tabe %<CR>
tnoremap <silent> <A-,>f <C-\><C-n>:sp<CR>
tnoremap <silent> <A-.>f <C-\><C-n>:vs<CR>

tnoremap <silent> <A-t> <C-\><C-n>:cd %:p:h<CR>i

tnoremap <silent> <A-g>m <C-\><C-n><C-w>_<C-w><bar>
tnoremap <silent> <A-g>e <C-\><C-n><C-w>=

tnoremap <silent> <A-g>n <C-\><C-n>:set number<CR>:set norelativenumber<CR>i
tnoremap <silent> <A-g>r <C-\><C-n>:set number<CR>:set relativenumber<CR>i

tnoremap <silent> <A-z> <C-\><C-n>:noh<CR>i

"completion
inoremap <A-p> <C-x><C-U>

"term esc
tnoremap <A-n> <C-\><C-n>

"open git locally
let $GIT_EDITOR = 'nvr -cc split --remote-wait'
autocmd FileType gitcommit set bufhidden=delete

"do I need this
set guicursor=

" Go to last active tab
if !exists('g:lasttab')
  let g:lasttab = 1
endif

nmap <silent> <A-Tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

"fzf maps
noremap <silent> <leader>gf <esc>:Files<CR>
noremap <silent> <leader>gg <esc>:GFiles<CR>
noremap <silent> <leader>gs <esc>:GFiles?<CR>
noremap <silent> <leader>gb <esc>:Buffers<CR>
noremap <silent> <leader>gr <esc>:Rg<CR>
noremap <silent> <leader>gl <esc>:BLines<CR>
noremap <silent> <leader>gal <esc>:Lines<CR>
noremap <silent> <leader>gt <esc>:BTags<CR>
noremap <silent> <leader>gat <esc>:Tags<CR>
noremap <silent> <leader>gm <esc>:Marks<CR>
noremap <silent> <leader>gw <esc>:Windows<CR>
noremap <silent> <leader>gh <esc>:History<CR>
noremap <silent> <leader>g: <esc>:History:<CR>
noremap <silent> <leader>g/ <esc>:History/<CR>
noremap <silent> <leader>gp <esc>:Snippets<CR>
noremap <silent> <leader>gc <esc>:BCommits<CR>
noremap <silent> <leader>gac <esc>:Commits<CR>
noremap <silent> <leader>go <esc>:Commands<CR>
noremap <silent> <leader>gn <esc>:Maps<CR>
noremap <silent> <leader>gk <esc>:Helptags<CR>
noremap <silent> <leader>gF <esc>:FileTypes<CR>

"coc options
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

" Use `[g` and `]g` for navigate diagnostics
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <leader>d <Plug>(coc-definition)
nmap <leader>t <Plug>(coc-type-definition)
nmap <leader>i <Plug>(coc-implementation)
nmap <leader>u <Plug>(coc-references)

" format
nmap <leader>f <Plug>(coc-format-selected)
vmap <leader>f <Plug>(coc-format-selected)

nmap <leader>F <Plug>(coc-format)

nmap <leader>e <Plug>(coc-rename)

nmap <leader>c <Plug>(coc-fix-current)

"java doc commenting (requires eclim/eclipse workspace)
"noremap <silent> <leader>c <esc>:JavaDocComment<CR>

noremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>

"show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"lightline options
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

let b:lion_squeeze_spaces = 1

"cleverf options
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms = 3000

"insertchar options
let g:insert_char_no_default_mapping = 1
nmap <leader>s <Plug>InsertChar
nmap <leader>S <Plug>InsertCharAfter

let g:wordmotion_prefix = ';'

"startify options
let g:startify_bookmarks = [{'B': '~/.bashrc'}, {'v': '~/.config/nvim/init.vim'},
      \ {'w': '~/.config/i3/config'}, {'t': 'term://bash'}, {'b': '~/.config/qutebrowser/config.py'},
      \ {'T': '~/Documents/efficiency/TODO/TODO_LIST.txt'}, {'s': '~/.config/i3status/config'}]

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ { 'type': 'files',     'header': ['   Recent']            },
      \ ]

"possible additonal entry
"      \ { 'type': 'dir',       'header': ['   Recent: '. getcwd()] },

let g:startify_skiplist = [
       \ 'init.vim',
       \ 'config',
       \ 'config.py'
       \ ]

let g:startify_custom_header =
      \ map(split(system('cat /home/ryan/Documents/efficiency/TODO/TODO_LIST.txt'), '\n'), '"   ". v:val')

"windowswap options 
let g:windowswap_map_keys = 0
nnoremap <silent> <leader>v :call WindowSwap#EasyWindowSwap()<CR>

"scratch options:
let g:scratch_no_mappings = 1

nmap gs <plug>(scratch-reuse)
nmap gS <plug>(scratch-clear)

xmap gs <plug>(scratch-selection-reuse)
xmap gS <plug>(scratch-selection-clear)

noremap <silent> <leader>zf :VimadeFadeLevel 0.7<cr>
noremap <silent> <leader>zF :VimadeFadeLevel 0.4<cr>

colorscheme gruvbox
