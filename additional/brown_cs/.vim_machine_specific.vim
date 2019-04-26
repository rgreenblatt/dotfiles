let g:disable_coc = 1

tnoremap <C-H> <C-\><C-n>

let g:startify_bookmarks = [{'s': '~/course/cs0180/workspace/scalaproject'}] 

let g:startify_commands = [{'t': 'GlobalSharedTerm'}, {'f': 'Files'}]
let g:startify_custom_header = ""
let g:startify_custom_footer = ""
let g:plugin_blacklist = {}
let g:plugin_blacklist.machine_specific = ['rgreenblatt/sneak-quick-scope', 
      \ 'lervag/vimtex', 'sheerun/vim-polyglot', 'LucHermitte/lh-vim-lib',
      \ 'LucHermitte/local_vimrc']
