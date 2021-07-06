local api = vim.api

api.nvim_set_var('NERDTreeShowHidden', 1)
api.nvim_set_var('NERDTreeQuitOnOpen', 1)
api.nvim_set_keymap('n', '<leader>t', ':NERDTreeToggle<cr>', {})
api.nvim_set_keymap('n', '<leader>T', ':NERDTreeFind<cr>', {})
