return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/vim-vsnip', -- required for autocompletion to work, even without snippets
    'nvim-autopairs',
    'onsails/lspkind-nvim',
    -- Copilot
     {
        'zbirenbaum/copilot-cmp',
        opts = {
          clear_after_cursor = true,
          completion_fn = 'getPanelCompletions',
        },
        dependencies = {
          {
            'zbirenbaum/copilot.lua',
            opts = {
              suggestion = { enabled = false },
              panel = { enabled = false },
            },
          },
        },
     },
  },
  init = function()
    vim.g.copilot_no_tab_map = true
  end,
  opts = function()
    local nvim_set_keymap = vim.api.nvim_set_keymap
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    lspkind.init({
      symbol_map = {
        Copilot = "",
      },
    })

    return {
      snippet = {
        expand = function(args)
          vim.fn['vsnip#anonymous'](args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping.scroll_docs(-4),
        ['<C-k>'] = cmp.mapping.scroll_docs(4),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Cr>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
        })
      },
      sources = {
        { name = 'vsnip' },
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'emoji' },
        { name = 'digraphs' },
      },
    }
  end,
  config = function()
    local cmp = require('cmp')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
  end
}
