local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

local opts = { silent = true }

nvim_set_keymap('n', 'z', '<Plug>Lightspeed_s', opts)
nvim_set_keymap('n', 'Z', '<Plug>Lightspeed_S', opts)
nvim_set_keymap('v', 'z', '<Plug>Lightspeed_s', opts)
nvim_set_keymap('v', 'Z', '<Plug>Lightspeed_S', opts)
nvim_set_keymap('x', 'z', '<Plug>Lightspeed_x', opts)
nvim_set_keymap('x', 'Z', '<Plug>Lightspeed_X', opts)

vim.api.nvim_set_keymap('n', ';', '<Plug>Lightspeed_;_ft', opts)
vim.api.nvim_set_keymap('x', ';', '<Plug>Lightspeed_;_ft', opts)
vim.api.nvim_set_keymap('n', ',', '<Plug>Lightspeed_,_ft', opts)
vim.api.nvim_set_keymap('x', ',', '<Plug>Lightspeed_,_ft', opts)

-- Lightseed is changing a lot. Sometimes these are needed, sometimes not.
--cmd('unmap s')
--cmd('unmap S')
