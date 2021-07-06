local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

vim.g['sneak#label'] = 1

cmd('hi Sneak ctermfg=black ctermbg=201')
cmd('hi SneakScope ctermfg=black ctermbg=white')
cmd('hi SneakLabel ctermfg=black ctermbg=201')

nvim_set_keymap('n', 'z', '<Plug>Sneak_s', {})
nvim_set_keymap('n', 'Z', '<Plug>Sneak_S', {})
nvim_set_keymap('x', 'z', '<Plug>Sneak_s', {})
nvim_set_keymap('x', 'Z', '<Plug>Sneak_S', {})
