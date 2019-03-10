"serious changes or remaps:
map Y y$

"clever-f

inoremap kj <esc>
inoremap jk <esc>

noremap ,m "_
vnoremap ,m "_

noremap ,j "+
vnoremap ,j "+

map , "

map <space> <leader>
map <space><space> <leader><leader>

"plugins
set nocompatible
filetype off
call plug#begin('~/.local/share/nvim/plugged')
" Plug 'dansomething/vim-eclim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'wikitopian/hardmode'
Plug 'inkarkat/vim-CountJump'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'wellle/targets.vim'
Plug 'itchyny/lightline.vim'
Plug 'rgreenblatt/i3-vim-focus'
Plug 'rgreenblatt/vim-insert-char'
Plug 'rgreenblatt/scratch.vim'
Plug 'rgreenblatt/vim-ninja-feet'
Plug 'rgreenblatt/c-conceal'
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
Plug 'tpope/vim-eunuch'
Plug 'makerj/vim-pdf'
Plug 'vim-scripts/restore_view.vim'
Plug 'unblevable/quick-scope'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-slash'
Plug 'TaDaa/vimade'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/clever-f.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'mhinz/vim-startify'
Plug 'wesQ3/vim-windowswap'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'
Plug 'flazz/vim-colorschemes'
Plug 'Carpetsmoker/xdg_open.vim'
Plug 'bfredl/nvim-miniyank'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'ehamberg/vim-cute-python'
Plug 'metakirby5/codi.vim'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/NrrwRgn'
Plug 'chrisbra/color_highlight'
Plug 'kien/rainbow_parentheses.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'itchyny/calendar.vim'
call plug#end()
filetype plugin indent on
 
"macros
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

noremap Q @@
set lazyredraw

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

"conceal
set conceallevel=2
let g:tex_conceal="abdgm"
noremap <leader><leader>c :<c-u>set <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=1'<CR><CR>

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

"general leader maps
noremap <silent> <leader>lt :<c-u>sp term://zsh<CR>
noremap <silent> <leader>;t :<c-u>vs term://zsh<CR>
noremap <silent> <leader>,t :<c-u>tabe term://zsh<CR>
noremap <silent> <leader>.t :<c-u>te<CR>

noremap <silent> <leader>ls :<c-u>sp<CR>:Startify<CR>
noremap <silent> <leader>;s :<c-u>vs<CR>:Startify<CR>
noremap <silent> <leader>,s :<c-u>tabe<CR>:Startify<CR>
noremap <silent> <leader>.s :<c-u>Startify<CR>

noremap <silent> <leader>lc :<c-u>Calendar -split=horizontal<CR>
noremap <silent> <leader>;c :<c-u>Calendar -split=vertical<CR>
noremap <silent> <leader>,c :<c-u>Calendar<CR>
noremap <silent> <leader>.c :<c-u>Calendar -position=here<CR>

noremap <silent> <leader>lf :<c-u>sp<CR>
noremap <silent> <leader>;f :<c-u>vs<CR>
noremap <silent> <leader>,f :<c-u>tabe %<CR>

noremap <silent> <leader>p :<c-u>cd %:p:h<CR>
noremap <silent> <leader><leader>n :<c-u>set invrelativenumber<CR>
noremap <silent> <leader><leader>w :<c-u>%s/\s\+$//<CR>:let @/=''<CR>
noremap <silent> <leader>z :<c-u>noh<CR>

noremap <silent> <leader>x :<c-u>x<CR>
noremap <silent> <leader>q :<c-u>q<CR>
noremap <silent> <leader>a :<c-u>qa<CR>

noremap <leader>wj <C-w>-
noremap <leader>wk <C-w>+
noremap <leader>wl <C-w>>
noremap <leader>wh <C-w><
noremap <leader>ww <C-w><bar>
noremap <leader>wt <C-w>_
noremap <leader>we <C-w>=
noremap <leader>wm <C-w><bar><C-w>_

noremap <leader>T <C-]>

"alt window navigation
noremap <silent> <A-l> <esc>:call Focus('right', 'l')<CR>
noremap <silent> <A-h> <esc>:call Focus('left', 'h')<CR>
noremap <silent> <A-k> <esc>:call Focus('up', 'k')<CR>
noremap <silent> <A-j> <esc>:call Focus('down', 'j')<CR>

noremap! <silent> <A-l> <esc>:call Focus('right', 'l')<CR>
noremap! <silent> <A-h> <esc>:call Focus('left', 'h')<CR>
noremap! <silent> <A-k> <esc>:call Focus('up', 'k')<CR>
noremap! <silent> <A-j> <esc>:call Focus('down', 'j')<CR>

tnoremap <silent> <A-l> <C-\><C-n>:call Focus('right', 'l')<CR>
tnoremap <silent> <A-h> <C-\><C-n>:call Focus('left', 'h')<CR>
tnoremap <silent> <A-k> <C-\><C-n>:call Focus('up', 'k')<CR>
tnoremap <silent> <A-j> <C-\><C-n>:call Focus('down', 'j')<CR>

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

nmap <silent> <A-Tab> :<c-u>exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

"fzf maps
noremap <leader>gf <esc>:<c-u>Files<space>
noremap <leader>gg <esc>:<c-u>GFiles<space>
noremap <leader>gs <esc>:<c-u>GFiles?<space>
noremap <leader>gb <esc>:<c-u>Buffers<cr>
noremap <leader>gr <esc>:<c-u>Rg<space>
noremap <leader>gl <esc>:<c-u>BLines<cr> 
noremap <leader>gal <esc>:<c-u>Lines<cr> 
noremap <leader>gt <esc>:<c-u>BTags<cr> 
noremap <leader>gat <esc>:<c-u>Tags<cr> 
noremap <leader>gm <esc>:<c-u>Marks<cr> 
noremap <leader>gw <esc>:<c-u>Windows<cr> 
noremap <leader>gh <esc>:<c-u>History<cr>
noremap <leader>g: <esc>:<c-u>History:<cr>
noremap <leader>g/ <esc>:<c-u>History/<cr>
noremap <leader>gp <esc>:<c-u>Snippets<cr>
noremap <leader>gc <esc>:<c-u>BCommits<cr>
noremap <leader>gac <esc>:<c-u>Commits<cr>
noremap <leader>go <esc>:<c-u>Commands<cr>
noremap <leader>gn <esc>:<c-u>Maps<cr>
noremap <leader>gk <esc>:<c-u>Helptags<cr>
noremap <leader>gF <esc>:<c-u>FileTypes<cr>

noremap <leader>Gf <esc>:<c-u>Files<cr>
noremap <leader>Gg <esc>:<c-u>GFiles<cr>
noremap <leader>Gs <esc>:<c-u>GFiles?<cr>
noremap <leader>Gr <esc>:<c-u>Rg<cr>

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

"show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"java doc commenting (requires eclim/eclipse workspace)
"noremap <silent> <leader><leader>j <esc>:<c-u>JavaDocComment<CR>

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

"changes to wordmotion
let g:wordmotion_prefix = ';'
set iskeyword+=-

"startify
let g:startify_bookmarks = [{'z': '~/.zshrc'}, {'v': '~/.config/nvim/init.vim'},
      \ {'w': '~/.config/i3/config'}, {'t': 'term://zsh'}, {'b': '~/.config/qutebrowser/config.py'},
      \ {'T': '~/Documents/efficiency/TODO/TODO_LIST.txt'}, {'s': '~/.config/i3status/config'}] 

let g:startify_commands = [{'c': 'Calendar -position=here'}]

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

"windowswap
let g:windowswap_map_keys = 0
nnoremap <silent> <leader>v :call WindowSwap#EasyWindowSwap()<CR>

"scratch
let g:scratch_no_mappings = 1

nmap gs <plug>(scratch-reuse)
nmap gS <plug>(scratch-clear)

xmap gs <plug>(scratch-selection-reuse)
xmap gS <plug>(scratch-selection-clear)

colorscheme gruvbox

"limelight/goyo
let g:limelight_conceal_ctermfg = 'DarkGray'

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
noremap <silent> <leader><leader>g :Goyo<cr>

function SetupGoyo() 
  Limelight
  noremap <silent> <leader><leader>g :Goyo!<cr>
endfunction

function SetupNoGoyo() 
  Limelight!
  noremap <silent> <leader><leader>g :Goyo<cr>
endfunction

autocmd! User GoyoEnter call SetupGoyo()
autocmd! User GoyoLeave call SetupNoGoyo()

let g:mwAutoLoadMarks = 1

"yankring
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

map ;o p;n
map ;O P;n

"total hack:
map ;p0 p
map ;p1 p;n
map ;p2 p;n;n
map ;p3 p;n;n;n
map ;p4 p;n;n;n;n
map ;p5 p;n;n;n;n;n
map ;p6 p;n;n;n;n;n;n
map ;p7 p;n;n;n;n;n;n;n
map ;p8 p;n;n;n;n;n;n;n;n
map ;p9 p;n;n;n;n;n;n;n;n;n

map ;P0 P
map ;P1 P;n
map ;P2 P;n;n
map ;P3 P;n;n;n
map ;P4 P;n;n;n;n
map ;P5 P;n;n;n;n;n
map ;P6 P;n;n;n;n;n;n
map ;P7 P;n;n;n;n;n;n;n
map ;P8 P;n;n;n;n;n;n;n;n
map ;P9 P;n;n;n;n;n;n;n;n;n

map ;n <Plug>(miniyank-cycle)
map ;N <Plug>(miniyank-cycleback)

noremap <silent> <leader><leader>f :<c-u>VimadeToggle<cr>

set shell=/bin/zsh

"rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

noremap <silent> <leader><leader>u :<c-u>MundoToggle<cr>

"NarrowRegion
let g:nrrw_rgn_nomap_nr = 1
let g:nrrw_rgn_nomap_Nr = 1

map ;r <Plug>NrrwrgnDo 
xmap ;R <Plug>NrrwrgnBangDo 

"vim-slash
noremap <plug>(slash-after) zz

"calender.vim
let g:calendar_google_task = 1
let g:calendar_google_calendar = 1
let g:calendar_view = 'week'
let g:calendar_cyclic_view = 1

augroup calendar-mappings
  autocmd!
  autocmd FileType calendar nunmap <buffer> <space>
augroup END
