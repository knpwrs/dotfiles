local cmd = vim.cmd
local wk = require('which-key')

require('bufferline').setup({
  options = {
    show_close_icon = false,
    show_buffer_close_icons = false,
    custom_filter = function(buf_number)
      -- don't show DAP REPL in buffline
      if vim.bo[buf_number].filetype ~= 'dap-repl' then
        return true
      end
    end,
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
      x = {
        name = 'Close Buffers',
        x = { '<Cmd>BufferLinePickClose<Cr>', 'Pick and Close Buffer' },
        h = { '<Cmd>BufferLineCloseLeft<Cr>', 'Close Buffers to the Left' },
        l = { '<Cmd>BufferLineCloseRight<Cr>', 'Close Buffers to the Right' },
        o = { [[<Cmd>%bd|e#|bd#<Cr>|'"<Cr>]], 'Close All Other Buffers' },
      },
      d = { '<Cmd>bd<Cr>', 'Delete Current Buffer' },
      o = { [[<Cmd>%bd|e#|bd#<Cr>|'"<Cr>]], 'Close All Other Buffers' },
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
