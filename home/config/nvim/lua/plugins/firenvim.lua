local wk = require('which-key')

vim.o.guifont='monospace:h11'

vim.g.firenvim_config = {
  localSettings = {
    [ [[.*]] ] = {
      cmdline = 'firenvim',
      priority = 0,
      selector = 'textarea:not([readonly]):not([class="handsontableInput"]), div[role="textbox"]',
      takeover = 'always',
    },
    [ [[.*docs\.google\.com.*]] ] = {
      prioirty = 9,
      takeover = 'never',
    },
    [ [[.*notion\.so.*]] ] = {
      priority = 9,
      takeover = 'never',
    },
  },
}

wk.register(
  {
    f = {
      name = 'firenvim',
      l = {
        function()
          if vim.o.lines < 10 or vim.o.lines == 20 then
            vim.o.lines = 10
          else
            vim.o.lines = 20
          end
        end,
        'Toggle number of lines between 10 and 20',
      },
      m = {
        function()
          vim.o.filetype = 'markdown'
        end,
        'Set filetype to markdown',
      },
    },
  },
  {
    prefix = '<Leader><Leader>',
  }
)
