local cmd = vim.cmd
local dapui = require('dapui')
local wk = require('which-key')

dapui.setup({
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_width = 0.5,
    max_height = 0.5,
  },
})

wk.register({
  du = {
    name = 'DAP UI',
    t = {
      name = 'Toggle',
      s = { function() dapui.toggle('sidebar') end, 'Toggle Sidebar' },
      t = { function() dapui.toggle('tray') end, 'Toggle Tray' },
    },
    r = { function() dapui.float_element('repl', { enter = true }) end, 'Float REPL' },
    b = { function() dapui.float_element('breakpoints', { enter = true }) end, 'Float Breakpoints' },
    s = { function() dapui.float_element('scopes', { enter = true }) end, 'Float Scopes' },
    S = { function() dapui.float_element('stacks', { enter = true }) end, 'Float Stacks' },
    w = { function() dapui.float_element('watches', { enter = true }) end, 'Float Watches' },
  },
}, {
  prefix = '<Leader>',
})
