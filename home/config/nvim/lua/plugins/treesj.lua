local wk = require('which-key')
local tsj = require('treesj')
local js = require('treesj.langs.javascript')
local ts = require('treesj.langs.typescript')
local tsx = require('treesj.langs.tsx')
local ruby = require('treesj.langs.ruby')

tsj.setup({
  use_default_keymaps = false,
  check_syntax_error = true,
  max_join_length = 120,
  cursor_behavior = 'hold',
  notify = true,
  langs = {
    javascript = js,
    typescript = ts,
    typescriptreact = tsx,
    ruby = ruby,
  },
})

wk.register(
  {
    S = { '<Cmd>TSJSplit<Cr>', 'Split Treesitter Node' },
    J = { '<Cmd>TSJJoin<Cr>', 'Join Treesitter Node' },
    M = { '<Cmd>TSJToggle<Cr>', 'Toggle Treesitter Node' },
  },
  {
    prefix = 'g'
  }
)
