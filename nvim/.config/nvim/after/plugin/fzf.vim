if exists("*IsInstalled") && IsInstalled('junegunn/fzf') && IsInstalled('rgreenblatt/fzf.vim')
  let g:fzf_files_options = fzf#vim#with_preview('right:50%').options
  let g:fzf_gfiles_options = g:fzf_files_options
endif
