local nvim_set_keymap = vim.api.nvim_set_keymap

vim.g.simple_todo_map_keys = 0

nvim_set_keymap('n', '<Leader>i', '<Plug>(simple-todo-new-list-item-start-of-line)', {})
nvim_set_keymap('n', '<Leader>o', '<Plug>(simple-todo-below)', {})
nvim_set_keymap('n', '<Leader>O', '<Plug>(simple-todo-above)', {})
nvim_set_keymap('n', '<Leader>x', '<Plug>(simple-todo-mark-as-done)', {})
nvim_set_keymap('n', '<Leader>X', '<Plug>(simple-todo-mark-as-undone)', {})
nvim_set_keymap('n', '<Leader>m', '<Plug>(simple-todo-mark-switch)', {})
nvim_set_keymap('n', '<Leader>x', '<Plug>(simple-todo-mark-as-done)', {})
nvim_set_keymap('n', '<Leader>X', '<Plug>(simple-todo-mark-as-undone)', {})
nvim_set_keymap('n', '<Leader>m', '<Plug>(simple-todo-mark-switch)', {})
