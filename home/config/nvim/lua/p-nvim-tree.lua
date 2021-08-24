local cmd = vim.cmd
local g = vim.g
local nvim_set_keymap = vim.api.nvim_set_keymap

nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<Cr>', {})
nvim_set_keymap('n', '<leader>T', ':NvimTreeFindFile<Cr>', {})

local tree_cb = require('nvim-tree.config').nvim_tree_callback

g.nvim_tree_bindings = {
  { key = 'd', cb = tree_cb('remove') },
  { key = 'm', cb = tree_cb('rename') },
  { key = 'M', cb = tree_cb('full_rename') },
  { key = 't', cb = tree_cb('tabnew') },
  { key = {'<Esc>', '<C-d>', 'q'}, cb = tree_cb('close') }
}

-- Close tree when opening file
g.nvim_tree_quit_on_open = 1

-- Icons
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 0,
  folder_arrows = 1,
}
