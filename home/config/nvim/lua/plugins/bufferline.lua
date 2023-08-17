return {
  'akinsho/bufferline.nvim',
  dependencies = {'nvim-web-devicons'},
  opts = {
    options = {
      show_close_icon = false,
      show_buffer_close_icons = false,
      diagnostics = 'nvim_lsp',
      custom_filter = function(buf_number)
        -- don't show DAP REPL in bufferline
        if vim.bo[buf_number].filetype ~= 'dap-repl' then
          return true
        end
      end,
    },
  },
  config = function()
    local cmd = vim.cmd
    local wk = require('which-key')

    -- Due to an upstream bug we need an autocmd to prevent quickfix from appearing in bufferline
    -- https://github.com/akinsho/bufferline.nvim/issues/176
    cmd([[
      augroup BufferlineUserConfig
        autocmd!
        autocmd FileType qf set nobuflisted
      augroup end
    ]])

    local opts = { noremap = true, silent = true }

    wk.register(
      {
        ['['] = { '<Cmd>BufferLineCyclePrev<Cr>', 'Previous Buffer' },
        [']'] = { '<Cmd>BufferLineCycleNext<Cr>', 'Next Buffer' },
        ['{'] = { '<Cmd>BufferLineMovePrev<Cr>', 'Move Buffer Right' },
        ['}'] = { '<Cmd>BufferLineMoveNext<Cr>', 'Move Buffer Left' },
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
          D = { '<Cmd>bd!<Cr>', 'Delete Current Buffer (Ignore Unsaved Changes)' },
          o = { [[<Cmd>%bd|e#|bd#<Cr>|'"<Cr>]], 'Close All Other Buffers' },
        }
      },
      {
        prefix = '<Leader>',
        silent = true,
      }
    )
  end
}
