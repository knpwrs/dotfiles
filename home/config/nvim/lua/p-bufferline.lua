local cmd = vim.cmd
local wk = require('which-key')

require('bufferline').setup({
  options = {
    show_close_icon = false,
    show_buffer_close_icons = false,
  },
})

local opts = { noremap = true, silent = true }

wk.register(
  {
    ['['] = { '<Cmd>BufferLineMovePrev<Cr>', 'Move Buffer Left' },
    [']'] = { '<Cmd>BufferLineMoveNext<Cr>', 'Move Buffer Right' },
    b = {
      name = 'Buffers',
      g = { '<Cmd>BufferLinePick<Cr>', 'Pick Buffer' },
      c = { '<Cmd>BufferLinePickClose<Cr>', 'Pick and Close Buffer' },
      d = { '<Cmd>bd<Cr>', 'Delete Current Buffer' },
    }
  },
  {
    prefix = '<Leader>',
  }
)

wk.register(
  {
    ['[b'] = { ':BufferLineCyclePrev<Cr>', 'Previous Buffer' },
    [']b'] = { ':BufferLineCycleNext<Cr>', 'Next Buffer' },
  }
)
