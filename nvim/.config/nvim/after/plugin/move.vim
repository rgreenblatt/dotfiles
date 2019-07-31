if exists("*IsInstalled") && IsInstalled('matze/vim-move') && IsInstalled('rgreenblatt/vim-wintabs')
  nmap <a-h> <Plug>(wintabs_previous)
  nmap <a-l> <Plug>(wintabs_next)
endif
