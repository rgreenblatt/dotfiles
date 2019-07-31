"generic setup {{{1
let g:athame_var = system("echo ${ATHAME_USE_JOBS+1}")
let g:athame_running = g:athame_var == "1\n"

if !empty($CONFIG_HOME)
  let machine_specific_path = expand("$CONFIG_HOME")
else
  let machine_specific_path = '~'
endif

execute "source " . machine_specific_path . "/.vim_machine_specific.vim"

function! s:Set(var, default)
  if !exists(a:var)
    execute "let " . a:var . " = " . a:default
  endif
endfunction

"default plug installs {{{1
call s:Set("g:disable_all_plugins", 0)
call s:Set("g:headless", 0)
call s:Set("g:no_language_plugins", 0)
call s:Set("g:no_coc", 0)
call s:Set("g:no_appearance_plugins", 0)
call s:Set("g:no_language_plugins", 0)
call s:Set("g:no_editing_plugins", 0)
call s:Set("g:no_setup_plugins", 0)
call s:Set("g:no_integration_plugins", 0)
call s:Set("g:no_misc_plugins", 0)

"athame overrides {{{1
let g:no_language_plugins = g:no_language_plugins || g:athame_running
let g:no_appearance_plugins = g:no_appearance_plugins || g:athame_running
let g:no_setup_plugins = g:no_setup_plugins || g:athame_running
let g:no_integration_plugins = g:no_integration_plugins || g:athame_running

"sourcing all files {{{1
let config_path=fnamemodify(expand('$MYVIMRC'), ':p:h')
execute 'source ' . config_path . '/remap.vim'
execute 'source ' . config_path . '/settings.vim'
execute 'source ' . config_path . '/autocmd.vim'
execute 'source ' . config_path . '/command.vim'
execute 'source ' . config_path . '/abbr.vim'
execute 'source ' . config_path . '/plug.vim'
execute 'source ' . config_path . '/plug_settings.vim'
execute 'source ' . config_path . '/plug_remap.vim'
" execute 'source ' . config_path . '/coc_fzf.vim'
execute 'source ' . config_path . '/statusline.vim'
"}}}1

" vim: set fdm=marker:
