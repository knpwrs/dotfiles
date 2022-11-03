local sd = vim.fn.sign_define
local wk = require('which-key')
local dap = require('dap')
local duw = require('dap.ui.widgets')

wk.register(
  {
    d = {
      name = 'DAP',
      b = {
        name = 'Breakpoints',
        b = { function() dap.toggle_breakpoint() end, 'Toggle Breakpoint' },
        c = { function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, 'Set Conditional Breakpoint' },
        e = { function() dap.set_exception_breakpoints() end, 'Set Exception Breakpoints' },
        E = { function() dap.set_exception_breakpoints({}) end, 'Clear Exception Breakpoints' },
        l = { function() dap.set_breakpoint(nil, nil, vim.fn.input('Logpoint message: ')) end, 'Set Logpoint' },
        L = { '<Cmd>FzfLua dap_breakpoints<Cr>', 'Breakpoints' },
      },
      s = {
        name = 'Steps',
        o = { function() dap.step_over() end, 'Step Over' },
        i = { function() dap.step_into() end, 'Step Into' },
        O = { function() dap.step_out() end, 'Step Out' },
      },
      t = { function () dap.run_to_cursor() end, 'Run to Cursor' },
      c = { function() dap.continue() end, 'Continue' },
      C = { '<Cmd>FzfLua dap_configurations<Cr>', 'Configurations' },
      R = { function() dap.run_last() end, 'Run Last' },
      k = { function() duw.hover() end, 'Hover' },
      x = {
        name = 'Stop',
        x = { function() dap.disconnect({ terminateDebuggee = true }) end; 'Terminate and Disconnect' },
        c = { function() dap.close() end; 'Close DAP Session' },
      },
      r = { function() dap.repl.open() end; 'Open Repl' },
      -- FzfLua Commands
      e = { '<Cmd>FzfLua dap_commands<Cr>', 'Commands' },
      v = { '<Cmd>FzfLua dap_variables<Cr>', 'Variables' },
      f = { '<Cmd>FzfLua dap_frames<Cr>', 'Frames' },
    },
  },
  {
    prefix = '<Leader>'
  }
)

sd('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError' })
sd('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignWarn' })
sd('DapLogPoint', { text = '', texthl = 'DiagnosticSignError' })
