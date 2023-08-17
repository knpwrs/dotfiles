return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
      lualine_bold = true,
      on_colors = function(colors)
        colors.bg = '#000000'
        colors.bg_dark = '#000000'
        colors.bg_sidebar = '#000000'
      end
    },
    init = function()
      vim.cmd[[colorscheme tokyonight-night]]
      -- Highlight yanked regions
      vim.cmd([[
        augroup HighlightYank
          autocmd!
          au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
        augroup END
      ]])
    end
  },
  {
    'chentoast/marks.nvim',
     opts = {}, -- TODO: is this needed?
  },
  {
    'folke/trouble.nvim',
    dependencies = {'nvim-web-devicons'},
    opts = {
      action_keys = {
        close = '<C-d>'
      },
    },
    config = function()
      local wk = require('which-key')

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
    end,
  },
  {
    'SmiteshP/nvim-navic',
    dependencies = {
      'neovim/nvim-lspconfig'
    },
    opts = {
      icons = {
        File          = ' ',
        Module        = ' ',
        Namespace     = ' ',
        Package       = ' ',
        Class         = ' ',
        Method        = ' ',
        Property      = ' ',
        Field         = ' ',
        Constructor   = ' ',
        Enum          = '練',
        Interface     = '練',
        Function      = ' ',
        Variable      = ' ',
        Constant      = ' ',
        String        = ' ',
        Number        = ' ',
        Boolean       = '◩ ',
        Array         = ' ',
        Object        = ' ',
        Key           = ' ',
        Null          = 'ﳠ ',
        EnumMember    = ' ',
        Struct        = ' ',
        Event         = ' ',
        Operator      = ' ',
        TypeParameter = ' ',
      },
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      highlight = false,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = '..',
      safe_output = true,
      click = false,
    },
  },
  {
    'edluffy/specs.nvim',
    opts = function(specs)
      return {
        popup = {
          fader = specs.exp_fader,
          winhl = 'Cursor',
        },
      }
    end,
  },
  {
    'folke/todo-comments.nvim',
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
      },
      search = {
        pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
      },
    },
    config = function()
      require('which-key').register(
        {
          lx = {
            t = { '<Cmd>TodoTrouble<Cr>', 'Toggle TODO Comments' },
          },
          f = {
            t = { '<Cmd>TodoTelescope<Cr>', 'TODO Comments' },
          },
        },
        {
          prefix = '<Leader>',
        }
      )
    end
  },
  { 'folke/which-key.nvim', lazy = true },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {'plenary.nvim'},
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 250,
      },
      current_line_blame_formatter = ' <author>, <author_time:%Y-%m-%d> - <summary>',
    },
    config = function()
      local gsa = require('gitsigns.actions')
      local wk = require('which-key')

      wk.register(
        {
          ['[h'] = { function() gsa.prev_hunk() end, 'Previous Git Hunk' },
          [']h'] = { function() gsa.next_hunk() end, 'Next Git Hunk' },
        }
      )

      wk.register(
        {
          h = {
            name = 'Git Hunks',
            s = { function() gsa.stage_hunk() end, 'Stage Hunk' },
            u = { function() gsa.undo_stage_hunk() end, 'Unstage Hunk' },
            r = { function() gsa.reset_hunk() end, 'Reset Hunk' },
            R = { function() gsa.reset_buffer() end, 'Reset Buffer' },
            p = { function() gsa.preview_hunk() end, 'Preview Hunk' },
          },
        },
        {
          prefix = '<Leader>',
        }
      )

      wk.register(
        {
          h = {
            name = 'Git Hunks',
            s = { function() gsa.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, 'Stage Hunks' },
            r = { function() gsa.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, 'Reset Hunks' },
          },
        },
        {
          prefix = '<Leader>',
          mode = 'v',
        }
      )

      wk.register(
        {
          i = {
            h = { function() gsa.select_hunk() end, 'Hunk' },
          },
        },
        {
          mode = 'o',
        }
      )

      wk.register(
        {
          i = {
            h = { function() gsa.select_hunk() end, 'Hunk' },
          },
        },
        {
          mode = 'x',
        }
      )
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_current_context = true,
    },
  },
  'luukvbaal/stabilize.nvim',
  {
    'voldikss/vim-floaterm',
    init = function()
      vim.g.floaterm_opener = 'edit'
    end,
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          x = {
            name = 'Floaterm',
            X = { '<Cmd>FloatermNew --title=xplr --cwd=<root> xplr<Cr>', 'xplr root' },
            x = { '<Cmd>FloatermNew --title=xplr xplr<Cr>', 'xplr' },
            d = { '<Cmd>FloatermNew --title=lazydocker lazydocker<Cr>', 'lazydocker' },
            g = { '<Cmd>FloatermNew --title=lazygit lazygit<Cr>', 'lazygit' },
            z = { '<Cmd>FloatermNew --title=term<Cr>', 'zsh' },
          },
        },
        {
          prefix = '<Leader>',
        }
      )
    end
  },
  {
    'yorickpeterse/nvim-window',
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          ['<Leader>w'] = { function() nw.pick() end, 'Pick Window' },
        }
      )
    end,
  },
}
