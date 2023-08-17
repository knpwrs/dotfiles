return {
  {
    'mfussenegger/nvim-dap',
    config = function()
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
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {'nvim-dap'},
    opts = {
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
    },
    config = function()
      local cmd = vim.cmd
      local dapui = require('dapui')
      local wk = require('which-key')

      wk.register(
        {
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
        },
        {
          prefix = '<Leader>',
        }
      )
    end,
  },
  'theHamsta/nvim-dap-virtual-text',
}
