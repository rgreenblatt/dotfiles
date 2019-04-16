
let g:startify_bookmarks = [{'z': '~/.zshrc'}, {'v': '~/.config/nvim/'},
      \ {'w': '~/.config/i3/config'}, 
      \ {'b': '~/.config/qutebrowser/config.py'},
      \ {'T': '~/Documents/efficiency/TODO/TODO_LIST.txt'}, 
      \ {'s': '~/.config/i3status/config'},
      \ {'p': '~/.profile'}, 
      \ {'K': '~/Documents/keyboard/src/keyboard/layers.py'}] 

let g:startify_commands = [{'m': 'te neomutt '}, {'t': 'GlobalSharedTerm'}, 
      \ {'c': 'Calendar -position=here'}, {'f': 'Files'}]
let g:startify_custom_header = ""
let g:startify_custom_footer =
      \ map(split(system('cat /home/ryan/Documents/efficiency'.
      \ '/TODO/TODO_LIST.txt'), '\n'), 
      \'"   ". v:val')
