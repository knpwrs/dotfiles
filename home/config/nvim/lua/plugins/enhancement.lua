return {
  {
    'AndrewRadev/dsf.vim',
    init = function()
      vim.g.dsf_brackets = '([{<'
      vim.opt.matchpairs:append('<:>')
    end,
  },
  {
    'AndrewRadev/sideways.vim',
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          H = { '<Cmd>SidewaysLeft<Cr>', 'Move Item Left' },
          L = { '<Cmd>SidewaysRight<Cr>', 'Move Item Right' },
        },
        {
          prefix = '<Leader>'
        }
      )
    end,
  },
  'andymass/vim-matchup',
  {
    'bfredl/nvim-luadev',
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          n = {
            name = 'nvim-luadev',
            r = { '<Plug>(Luadev-Run)', 'Run' },
            rr = { '<Plug>(Luadev-RunLine)', 'Run' },
          }
        },
        {
          prefix = '<Leader>',
        }
      )
    end
  },
  'dhruvasagar/vim-table-mode',
  {
    'echasnovski/mini.bracketed',
    branch = 'stable',
  },
  {
    'ggandor/lightspeed.nvim',
    config = function()
      local cmd = vim.cmd
      local nvim_set_keymap = vim.api.nvim_set_keymap

      local opts = { silent = true }

      -- TODO: should this be lazy-nvim keys?
      nvim_set_keymap('n', 'z', '<Plug>Lightspeed_s', opts)
      nvim_set_keymap('n', 'Z', '<Plug>Lightspeed_S', opts)
      nvim_set_keymap('v', 'z', '<Plug>Lightspeed_s', opts)
      nvim_set_keymap('v', 'Z', '<Plug>Lightspeed_S', opts)
      nvim_set_keymap('x', 'z', '<Plug>Lightspeed_x', opts)
      nvim_set_keymap('x', 'Z', '<Plug>Lightspeed_X', opts)

      vim.api.nvim_set_keymap('n', ';', '<Plug>Lightspeed_;_ft', opts)
      vim.api.nvim_set_keymap('x', ';', '<Plug>Lightspeed_;_ft', opts)
      vim.api.nvim_set_keymap('n', ',', '<Plug>Lightspeed_,_ft', opts)
      vim.api.nvim_set_keymap('x', ',', '<Plug>Lightspeed_,_ft', opts)
    end,
  },
  {
    'echasnovski/mini.files',
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          t = { function() MiniFiles.open() end, 'Toggle File Tree' },
          T = { function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, 'Show Current File in Tree' },
        },
        {
          prefix = '<Leader>',
        }
      )

    end
  },
  'godlygeek/tabular',
  {
    'jpalardy/vim-slime',
    init = function ()
      vim.g.slime_target = 'tmux'
      vim.g.slime_paste_file = vim.fn.tempname()
      vim.g.slim_bracketed_paste = 1
      vim.g.slime_default_config = {
        -- Lua doesn't have a string split function!
        socket_name = vim.api.nvim_eval('get(split($TMUX, ","), 0)'),
        target_pane = '{top-right}',
      }
    end,
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          S = {
            name = 'Slime',
            D = { '<Cmd>SlimeSend1 <C-d><Cr>',  'Send <C-d>' },
            d = { '<Cmd>SlimeSend1 deno<Cr>',  'Launch Deno REPL' },
            n = { '<Cmd>SlimeSend1 node<Cr>',  'Launch Node REPL' },
            p = { '<Cmd>SlimeSend1 python<Cr>',  'Launch Python REPL' },
            r = { '<Cmd>SlimeSend1 irb<Cr>',  'Launch Ruby REPL' },
            R = { '<Cmd>SlimeSend1 bin/rails console<Cr>',  'Launch Rails Console' },
          }
        },
        {
          prefix = '<Leader>',
        }
      )
    end
  },
  {
    'lambdalisue/suda.vim',
    config = function()
      -- TODO: temporary
      -- :ww writes with sudo (temporary)
      -- https://github.com/neovim/neovim/issues/1716
      -- https://github.com/lambdalisue/suda.vim
      -- command! -nargs=0 WriteWithSudo :w !sudo tee % > /dev/null
      -- cnoreabbrev ww WriteWithSudo
      vim.cmd('cnoreabbrev ww SudaWrite')
    end
  },
  {
    'mhinz/vim-grepper',
    cmd = {'Grepper'},
    keys = {'gs', '<Leader>g', '<Leader>G'},
    init = function()
      vim.g.grepper = {
        tools = {'rg', 'git'},
        rg = {
          grepprg = 'rg -H --no-heading --vimgrep --hidden'
        },
      }
    end,
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          g = { '<Cmd>Grepper<Cr>', 'Grepper' },
          G = { '<Cmd>Grepper -buffers<Cr>', 'Grepper Buffers' },
          ['*'] = { '<Cmd>Grepper -cword -noprompt<Cr>', 'Grepper Word Under Cursor' },
        },
        {
          prefix = '<Leader>',
        }
      )


      wk.register(
        {
          gs = { '<Plug>(GrepperOperator)', 'Grepper Operator' },
        },
        {
          mode = 'n',
        }
      )

      wk.register(
        {
          gs = { '<Plug>(GrepperOperator)', 'Grepper Operator' },
        },
        {
          mode = 'x',
        }
      )
    end,
  },
  {
    'numToStr/Comment.nvim',
    dependencies = {'JoosepAlviste/nvim-ts-context-commentstring'},
    opts = {
      pre_hook = function(ctx)
        local U = require 'Comment.utils'

        local location = nil
        if ctx.ctype == U.ctype.block then
          location = csutils.get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = csutils.get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring {
          key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
          location = location,
        }
      end,
    },
    config = function()
      local csutils = require('ts_context_commentstring.utils')

      require('nvim-treesitter.configs').setup({
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        }
      })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'arkav/lualine-lsp-progress' },
    opts = {
      options = {
        theme = 'tokyonight',
        component_separators = {},
        section_separators = {},
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {
          {
            'filename',
            path = 1,
          },
          {
            'navic',
            color_correction = nil,
            navic_opts = nil,
          },
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'lsp_progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {
        'nvim-tree',
        {
          sections = {
            lualine_z = {'filetype'},
          },
          filetypes = {'dapui_scopes', 'dapui_breakpoints', 'dapui_stacks', 'dapui_watches'},
        },
      },
    },
  },
  {
    'rmagatti/auto-session',
    opts = {
      auto_restore_enabled = false,
    },
  },
  {
    'RRethy/nvim-treesitter-endwise',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
  },
  'sickill/vim-pasta',
  {
    'sindrets/winshift.nvim',
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          m = { '<Cmd>WinShift<Cr>', 'Enter Win-Move Mode' },
        },
        {
          prefix = '<C-w>',
        }
      )
    end,
  },
  {
    'szw/vim-maximizer',
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          z = { '<Cmd>MaximizerToggle!<Cr>', 'Toggle Maximization' },
        },
        {
          prefix = '<C-w>',
        }
      )
    end,
  },
  'tmux-plugins/vim-tmux-focus-events',
  'tommcdo/vim-exchange',
  {
    'tommcdo/vim-fugitive-blame-ext',
    dependencies = {'vim-fugitive'},
  },
  'tpope/vim-abolish',
  { 'tpope/vim-dadbod', cmd = {'DB'} },
  'tpope/vim-eunuch',
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-speeddating',
  'tpope/vim-surround',
  {
    'vitalk/vim-simple-todo',
    init = function()
      vim.g.simple_todo_map_keys = 0
    end,
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          m = {
            name = 'Simple Todo',
            i = { '<Plug>(simple-todo-new-list-item-start-of-line)', 'Make new list item from this line' },
            o = { '<Plug>(simple-todo-below)', 'Make new list item below this line' },
            O = { '<Plug>(simple-todo-above)', 'Make new list item above this line' },
            x = { '<Plug>(simple-todo-mark-as-done)', 'Mark this line as done' },
            X = { '<Plug>(simple-todo-mark-as-undone)', 'Mark this line as undone' },
            m = { '<Plug>(simple-todo-mark-switch)', 'Toggle this line as done' },
          },
        },
        {
          prefix = '<Leader>',
        }
      )

    end,
  },
  {
    'Wansmer/treesj',
    dependencies = {'nvim-treesitter'},
    opts = function()
      local tsj = require('treesj')
      local js = require('treesj.langs.javascript')
      local ts = require('treesj.langs.typescript')
      local tsx = require('treesj.langs.tsx')
      local ruby = require('treesj.langs.ruby')

      return {
        use_default_keymaps = false,
        check_syntax_error = true,
        max_join_length = 120,
        cursor_behavior = 'hold',
        notify = true,
        langs = {
          javascript = js,
          typescript = ts,
          typescriptreact = tsx,
          ruby = ruby,
        },
      }
    end,
    config = function()
      local wk = require('which-key')

      wk.register(
        {
          S = { '<Cmd>TSJSplit<Cr>', 'Split Treesitter Node' },
          J = { '<Cmd>TSJJoin<Cr>', 'Join Treesitter Node' },
          M = { '<Cmd>TSJToggle<Cr>', 'Toggle Treesitter Node' },
        },
        {
          prefix = 'g',
        }
      )
    end,
  },
  'windwp/nvim-autopairs',
  {
    'windwp/nvim-ts-autotag',
    config = function()
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          update_in_insert = true,
        }
      )
    end
  },
}
