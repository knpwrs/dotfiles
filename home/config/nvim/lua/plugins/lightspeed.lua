local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

nvim_set_keymap('n', 'z', '<Plug>Lightspeed_s', {})
nvim_set_keymap('n', 'Z', '<Plug>Lightspeed_S', {})
nvim_set_keymap('x', 'z', '<Plug>Lightspeed_s', {})
nvim_set_keymap('x', 'Z', '<Plug>Lightspeed_S', {})

function repeat_ft(reverse)
  local ls = require'lightspeed'
  ls.ft['instant-repeat?'] = true
  ls.ft:to(reverse, ls.ft['prev-t-like?'])
end

opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>', opts)
vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>', opts)
vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>', opts)
vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>', opts)
