local nvim_set_keymap = vim.api.nvim_set_keymap

if not pcall(require, 'trouble') then
  return
end

require('trouble').setup {}

local opts = { silent = true, noremap = true }

nvim_set_keymap('n', '<Leader>xx', '<CMD>TroubleToggle<CR>', opts)
nvim_set_keymap('n', '<Leader>xw', '<CMD>TroubleToggle lsp_workspace_diagnostics<CR>', opts)
nvim_set_keymap('n', '<Leader>xd', '<CMD>TroubleToggle lsp_document_diagnostics<CR>', opts)
nvim_set_keymap('n', '<Leader>xl', '<CMD>TroubleToggle loclist<CR>', opts)
nvim_set_keymap('n', '<Leader>xq', '<CMD>TroubleToggle quickfix<CR>', opts)
nvim_set_keymap('n', '<Leader>gR', '<CMD>TroubleToggle lsp_references<CR>', opts)
