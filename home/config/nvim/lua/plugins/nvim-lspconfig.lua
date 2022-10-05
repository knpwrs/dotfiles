local wk = require('which-key')
local lspinstaller = require('nvim-lsp-installer')
local lspconfig = require('lspconfig')
local illum = require('illuminate')
local aerial = require('aerial')
local lsp = vim.lsp
local diag = vim.diagnostic

wk.register(
  {
    l = {
      name = 'LSP',
      a = { '<Cmd>AerialToggle<Cr>', 'Toggle Aerial' } ,
      e = { '<Cmd>lua vim.lsp.buf.code_action()<Cr>', 'Code Actions' },
      f = { function() lsp.buf.formatting() end, 'Format' },
      i = { function() lsp.buf.implementation() end, 'Implementation' },
      k = { function() lsp.buf.hover() end, 'Hover' },
      l = { function() diag.open_float() end, 'Show Line Diagnostics' },
      q = { function() diag.setloclist() end, 'Set Location List' },
      R = { '<Cmd>LspRestart<Cr>', 'Restart LSP' },
      m = { function() lsp.buf.rename() end, 'Rename' },
      y = { function() lsp.buf.type_definition() end, 'Type Definition' },
      -- Telescope lsp maps
      D = { '<Cmd>Telescope lsp_document_diagnostics<Cr>', 'Diagnostics' },
      I = { '<Cmd>Telescope lsp_implementations<Cr>', 'Implementations' },
      d = { '<Cmd>Telescope lsp_definitions<Cr>', 'Definitions' },
      r = { '<Cmd>Telescope lsp_references<Cr>', 'References' },
      s = { '<Cmd>Telescope lsp_document_symbols<Cr>', 'Symbols' },
      -- nvim-lsp-installer maps
      L = { '<Cmd>LspInstallInfo<Cr>', 'nvim-lsp-installer UI' },
    },
  },
  {
    prefix = '<Leader>',
  }
)

wk.register(
  {
    ['[d'] = { function() diag.goto_prev() end, 'Previous Diagnostic' },
    [']d'] = { function() diag.goto_next() end, 'Next Diagnostic' },
    -- vim-illuminate maps
    [']i'] = { function() illum.next_reference({ wrap = true }) end, 'Move to next doc highlight' },
    ['[i'] = { function() illum.next_reference({ wrap = true, reverse = true }) end, 'Move to prev doc highlight' },
  }
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspinstaller.setup()

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- Prefer prettier for TypeScript, JSON, and YAML
      return client.name ~= 'tsserver' and client.name ~= 'jsonls' and client.name ~= 'yamlls'
    end,
    bufnr = bufnr,
  })
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

for _, server in ipairs(lspinstaller.get_installed_servers()) do
  lspconfig[server.name].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- Automatically format for servers which support it
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end

      -- Attach vim-illuminate
      illum.on_attach(client)

      -- Attach aerial.nvim
      aerial.on_attach(client, bufnr)
    end,
  })
end

-- Disable illuminate in fugitiveblame
vim.g.Illuminate_ftblacklist = { 'fugitiveblame' }
