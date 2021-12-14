local nls = require('null-ls')
local lspconfig = require('lspconfig')

local function on_attach(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

local function prettier_condition(utils)
  -- See https://prettier.io/docs/en/configuration.html
  local files = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettier.config.js',
    '.prettier.config.cjs',
    '.prettierrc.toml',
  }
  for i=1,#files do
    if utils.root_has_file(files[i]) then
      return true
    end
  end

  return false
end

local sources = {
  nls.builtins.formatting.prettierd.with({
    condition = prettier_condition,
  })
}

nls.config({
  on_attach = on_attach,
  sources = sources,
})
