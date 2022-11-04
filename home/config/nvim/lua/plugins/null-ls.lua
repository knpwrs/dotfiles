local nls = require('null-ls')

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

  return utils.has_file(files) or utils.root_has_file(files)
end

local function vale_condition(utils)
  return utils.has_file('.vale.ini') or utils.root_has_file('.vale.ini')
end

local function sqlfluff_condition(utils)
  return utils.has_file('.sqlfluff') or utils.root_has_file('.sqlfluff')
end

local sources = {
  nls.builtins.formatting.prettier.with({
    condition = prettier_condition,
  }),
  nls.builtins.formatting.sqlfluff.with({
    condition = sqlfluff_condition,
  }),
  nls.builtins.diagnostics.vale.with({
    condition = vale_condition,
  }),
}

nls.setup({
  sources = sources,
})
