local wk = require('which-key')
local fzf = require('fzf-lua')

fzf.setup({
  keymap = {
    fzf = {
      ['ctrl-d'] = 'abort',
    }
  },
})

wk.register(
  {
    f = {
      name = 'FzfLua',
      f = { '<Cmd>FzfLua files <Cr>', 'Files' },
      g = { '<Cmd>FzfLua live_grep<Cr>', 'Live Grep' },
      s = { '<Cmd>FzfLua grep_cword<Cr>', 'Grep word Under Cursor' },
      b = { '<Cmd>FzfLua buffers<Cr>', 'Buffers' },
      l = { '<Cmd>FzfLua blines<Cr>', 'Current Buffer Lines' },
      r = { '<Cmd>FzfLua registers<Cr>', 'Registers' },
      h = { '<Cmd>FzfLua help_tags<Cr>', 'Help Tags' },
      c = { '<Cmd>FzfLua commands<Cr>', 'Commands' },
      k = { '<Cmd>FzfLua keymaps<Cr>', 'Keymaps' },
      T = { '<Cmd>FzfLua builtin<Cr>', 'FzfLua Built-in Commands' },
      ['='] = { '<Cmd>FzfLua spell_suggest<Cr>', 'Spelling Suggestions' },
    },
  },
  {
    prefix = '<Leader>'
  }
)
