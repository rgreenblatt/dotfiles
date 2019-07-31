if exists("*IsInstalled") && IsInstalled('vim-scripts/restore_view.vim')
  augroup AutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePre ?* if MakeViewCheck() | silent! mkview | endif
    autocmd BufRead ?* if MakeViewCheck() | silent! loadview | endif
  augroup END
endif
