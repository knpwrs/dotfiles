local wk = require('which-key')

vim.g.slime_target = 'tmux'
vim.g.slime_paste_file = vim.fn.tempname()
vim.g.slim_bracketed_paste = 1
vim.g.slime_default_config = {
  -- Lua doesn't have a string split function!
  socket_name = vim.api.nvim_eval('get(split($TMUX, ","), 0)'),
  target_pane = '{top-right}',
}

wk.register(
  {
    S = {
      name = 'Slime',
      D = { '<Cmd>SlimeSend1 <C-d><Cr>',  'Send <C-d>' },
      d = { '<Cmd>SlimeSend1 deno<Cr>',  'Launch Deno REPL' },
      n = { '<Cmd>SlimeSend1 node<Cr>',  'Launch Node REPL' },
      p = { '<Cmd>SlimeSend1 python<Cr>',  'Launch Python REPL' },
      r = { '<Cmd>SlimeSend1 irb<Cr>',  'Launch Ruby REPL' },
      R = { '<Cmd>SlimeSend1 bin/rails console<Cr>',  'Launch Rails Console' },
    }
  }, {
    prefix = '<Leader>',
  }
)
