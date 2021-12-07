local wk = require('which-key')
local li = require('nvim-lsp-installer')
local lsp = vim.lsp
local diag = vim.diagnostic

wk.register(
  {
    l = {
      name = 'LSP',
      f = { function() lsp.buf.formatting() end, 'Format' },
      i = { function() lsp.buf.implementation() end, 'Implementation' },
      k = { function() lsp.buf.hover() end, 'Hover' },
      l = { function() diag.open_float() end, 'Show Line Diagnostics' },
      q = { function() diag.set_loclist() end, 'Set Location List' },
      m = { function() lsp.buf.rename() end, 'Rename' },
      y = { function() lsp.buf.type_definition() end, 'Type Definition' },
      -- Telescope lsp maps
      D = { '<Cmd>Telescope lsp_document_diagnostics<Cr>', 'Diagnostics' },
      I = { '<Cmd>Telescope lsp_implementations<Cr>', 'Implementations' },
      d = { '<Cmd>Telescope lsp_definitions<Cr>', 'Definitions' },
      e = { '<Cmd>Telescope lsp_code_actions<Cr>', 'Code Actions' },
      r = { '<Cmd>Telescope lsp_references<Cr>', 'References' },
      s = { '<Cmd>Telescope lsp_document_symbols<Cr>', 'Symbols' },
      -- nvim-lsp-installer maps
      L = { '<Cmd>LspInstallInfo<Cr>', 'nvim-lsp-installer UI' },
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

li.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
  }

  if server.name == 'tsserver' then
    opts.on_attach = function(client)
      -- Prefer prettier over tsserver formatting
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)
