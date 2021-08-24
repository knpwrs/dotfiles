local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

require('bufferline').setup({
  options = {
    show_close_icon = false,
    show_buffer_close_icons = false,
  },
})

local opts = { noremap = true, silent = true }

nvim_set_keymap('n', '[b', ':BufferLineCyclePrev<cr>', opts)
nvim_set_keymap('n', ']b', ':BufferLineCycleNext<cr>', opts)
nvim_set_keymap('n', '<Leader>[', ':BufferLineMovePrev<cr>', opts)
nvim_set_keymap('n', '<Leader>]', ':BufferLineMoveNext<cr>', opts)
nvim_set_keymap('n', '<Leader>gb', ':BufferLinePick<cr>', opts)
nvim_set_keymap('n', '<Leader>gd', ':BufferLinePickClose<cr>', opts)
nvim_set_keymap('n', '<Leader>bd', ':bd<cr>', opts)
