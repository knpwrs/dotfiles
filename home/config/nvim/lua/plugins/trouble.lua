local wk = require('which-key')

if not pcall(require, 'trouble') then
  return
end

require('trouble').setup {
  action_keys = {
    close = '<C-d>'
  },
}

local opts = { silent = true, noremap = true }

wk.register(
  {
    lx = {
      name = 'Trouble',
      x = { '<Cmd>TroubleToggle<Cr>', 'Toggle Trouble' },
      w = { '<Cmd>TroubleToggle workspace_diagnostics<Cr>', 'Toggle Workspace Diagnostics' },
      d = { '<Cmd>TroubleToggle document_diagnostics<Cr>', 'Toggle Document Diagnostics' },
      l = { '<Cmd>TroubleToggle loclist<Cr>', 'Toggle Loclist Diagnostics' },
      q = { '<Cmd>TroubleToggle quickfix<Cr>', 'Toggle Quickfix Diagnostics' },
      r = { '<Cmd>TroubleToggle lsp_references<Cr>', 'Toggle LSP References' },
    },
  },
  {
    prefix = '<Leader>',
  }
)
