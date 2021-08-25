local nvim_set_keymap = vim.api.nvim_set_keymap

-- Mappings
local opts = { noremap = true, silent = true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', opts)
nvim_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<Cr>', opts)
nvim_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
nvim_set_keymap('n', 'gy', '<Cmd>lua vim.lsp.buf.type_definition()<Cr>', opts)
nvim_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
nvim_set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
nvim_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<Cr>', opts)
nvim_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<Cr>', opts)
nvim_set_keymap('n', '<Leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<Cr>', opts)
nvim_set_keymap('n', '<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<Cr>', opts)

-- Telescope lsp maps
nvim_set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions<Cr>', opts)
nvim_set_keymap('n', 'gr', '<Cmd>Telescope lsp_references<Cr>', opts)
nvim_set_keymap('n', 'gp', '<Cmd>Telescope lsp_document_symbols<Cr>', opts)
nvim_set_keymap('n', 'ge', '<Cmd>Telescope lsp_code_actions<Cr>', opts)
nvim_set_keymap('n', 'gD', '<Cmd>Telescope lsp_document_diagnostics<Cr>', opts)
nvim_set_keymap('n', 'gI', '<Cmd>Telescope lsp_implementations<Cr>', opts)

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
