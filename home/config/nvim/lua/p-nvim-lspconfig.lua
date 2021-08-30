local wk = require('which-key')
local lsp = vim.lsp

wk.register(
  {
    l = {
      name = 'LSP',
      f = { function() lsp.buf.formatting() end, 'Format' },
      i = { function() lsp.buf.implementation() end, 'Implementation' },
      k = { function() lsp.buf.hover() end, 'Hover' },
      q = { function() lsp.diagnostic.set_loclist() end, 'Set Location List' },
      r = { function() lsp.buf.rename() end, 'Rename' },
      y = { function() lsp.buf.type_definition() end, 'Type Definition' },
      -- Telescope lsp maps
      D = { '<Cmd>Telescope lsp_document_diagnostics<Cr>', 'Diagnostics' },
      I = { '<Cmd>Telescope lsp_implementations<Cr>', 'Implementations' },
      d = { '<Cmd>Telescope lsp_definitions<Cr>', 'Definitions' },
      e = { '<Cmd>Telescope lsp_code_actions<Cr>', 'Code Actions' },
      p = { '<Cmd>Telescope lsp_document_symbols<Cr>', 'Symbols' },
      r = { '<Cmd>Telescope lsp_references<Cr>', 'References' },
    },
  },
  {
    prefix = '<Leader>'
  }
)

wk.register(
  {
    ['[d'] = { function() lsp.diagnostic.goto_prev() end, 'Previous Diagnostic' },
    [']d'] = { function() lsp.diagnostic.goto_next() end, 'Next Diagnostic' },
  }
)

local function setup_servers()
  require('lspinstall').setup()
  local servers = require('lspinstall').installed_servers()
  for _, server in pairs(servers) do
    require('lspconfig')[server].setup {}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require('lspinstall').post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.CMD('bufdo e') -- this triggers the FileType autocmd that starts the server
end
