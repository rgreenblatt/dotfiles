"fzf {{{1
if IsInstalled('junegunn/fzf') && IsInstalled('rgreenblatt/fzf.vim')
  function! RgPreview(args, extra_args)
    call fzf#vim#grep("rg --column --line-number --no-heading " .
          \ "--color=always --smart-case " . a:extra_args . " " .
          \ shellescape(a:args), 1, {'options' :
          \ fzf#vim#with_preview('right:50%').options +
          \ ['--bind', 'alt-e:execute-silent(remote_tab_open_grep {} &)']})
  endfunction

  function! RgPreviewHidden(args, extra_args)
    call RgPreview(a:args, '--hidden --glob "!.git/*" ' . a:extra_args)
  endfunction

  command! -nargs=* RgPreview call RgPreview(<q-args>, '')
  command! -nargs=* RgPreviewHidden call RgPreviewHidden(<q-args>, '')
endif

let g:fzf_layout = { 'window': 'call FloatingFullscreen() | enew' }

call MapWinCmd("f", "Files", 0)
call MapWinCmd("F", "Files ", 1)
call MapWinCmd("'", "GFiles?", 0)
call MapWinCmd("g", "GFiles", 0)
call MapWinCmd("G", "GFiles ", 1)
call MapWinCmd("r", "RgPreviewHidden ", 1)
call MapWinCmd("R", "RgPreviewHidden", 0)
call MapWinCmd(";r", "RgPreview ", 1)
call MapWinCmd(";R", "RgPreview", 0)
call MapWinCmd("l", "BLines", 0)
call MapWinCmd("L", "Lines", 0)
call MapWinCmd(";t", "Tags", 0)
call MapWinCmd(";T", "BTags", 0)
call MapWinCmd("m", "call fzf#vim#marks()", 0)
call MapWinCmd("h", "History", 0)
call MapWinCmd("q", "Commits", 0)
call MapWinCmd("Q", "BCommits", 0)
call MapWinCmd("o", "commands", 0)
call MapWinCmd("b", "Buffers", 0)
call MapWinCmd("E", "ZshExecutables", 0)

nnoremap <Space>B <Cmd>Wipeouts<cr>

" vim: set fdm=marker:
