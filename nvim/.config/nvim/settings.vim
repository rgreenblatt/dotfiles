" generic settings {{{1
set viminfo='19,<1000,s1000
set viewoptions=cursor,folds,slash,unix
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,globals
set relativenumber
set number
set lazyredraw
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set wildmode=longest,list,full
set wildmenu
set conceallevel=2
set colorcolumn=81
set ignorecase
set smartcase
set hidden
set cmdheight=3
set updatetime=100
set shortmess+=c
set autowrite
set gdefault
set cursorline
set noshowmode
set foldmethod=syntax
set scrolloff=1
set showtabline=2
set winminwidth=0
set winminheight=0
set winwidth=1
set backupdir=~/.local/share/nvim/backup/,.backup/,~/.backup/,/tmp//
set directory=~/.local/share/nvim/swap/,.swap/,~/.swap/,/tmp//
set undodir=~/.local/share/nvim/undo/,.undo/,~/.undo/,/tmp//
set undofile

" potentially available {{{1
if has('termguicolors')
  set termguicolors
endif

function! s:TrySettingSingle(name)
  try
    execute 'set ' . a:name
  catch /E518/
  endtry
endfunction

function! s:TrySetting(name, value)
  try
    execute 'set ' . a:name . '=' . a:value
  catch /E518/
  endtry
endfunction

call s:TrySetting('floatblend', '20')
call s:TrySettingSingle('nomodelineexpr')
call s:TrySetting('pumblend', '20')
call s:TrySetting('signcolumn', 'yes:1')

" misc {{{1
try
  packadd termdebug
catch /E919/
endtry
"}}}

" vim: set fdm=marker:
