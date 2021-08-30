--
-- Global Keymaps
--

local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap
local wk = require('which-key')

-- Close quickfix if in quickfix
nvim_set_keymap('n', '<C-d>', '&bt ==# "quickfix" ? ":ccl<Cr>" : "<C-d>"', { noremap = true, expr = true })

-- Use <C-d> as escape sequence
nvim_set_keymap('i', '<C-d>', '<Esc>', {})
nvim_set_keymap('c', '<C-d>', '<Esc>', {})
nvim_set_keymap('v', '<C-d>', '<Esc>', {})

-- Toggle relative line numbers
cmd([[
  function! NumberToggle()
    if (&relativenumber == 1)
      set norelativenumber
      set number
    else
      set nonumber
      set relativenumber
    endif
  endfunc
]])
nvim_set_keymap('n', '<C-n>', ':call NumberToggle()<Cr>', { noremap = true })

-- <C-l> redraws the screen and removes any search highlighting.
nvim_set_keymap('n', '<C-l>', ':nohl<Cr><C-l>', { noremap = true })

-- Do not jump on invocation of *
nvim_set_keymap('n', '*', ':keepjumps normal! mi*`i<Cr>', {})

-- Execute macro over lines in visual mode
cmd([[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])
nvim_set_keymap('x', '@', ':<C-u>call ExecuteMacroOverVisualRange()<Cr>', { noremap = true })

wk.register(
  {
    r = {  ':%s/<C-r><C-w>//g<Left><Left>', 'Replace Word Under Cursor' },
    s = { '<Cmd>set spell!<Cr>', 'Toggle Spellchecking' },
    P = { '<Cmd>set paste!<Cr>', 'Toggle Paste Mode' },
    [','] = { '<Cmd>e $MYVIMRC<Cr>', 'Edit init.lua' },
    ['-'] = { '<Cmd>split<Cr>', 'Horizontal Split' },
    ['|'] = { '<Cmd>vsplit<Cr>', 'Vertical Split' },
  },
  {
    prefix = '<Leader>',
  }
)

-- Copy/yank file paths
nvim_set_keymap('n', 'cp', ':let @*=expand("%")<Cr>', {})
nvim_set_keymap('n', 'cP', ':let @*=expand("%:p")<Cr>', {})
nvim_set_keymap('n', 'yp', ':let @"=expand("%")<Cr>', {})
nvim_set_keymap('n', 'yP', ':let @"=expand("%:p")<Cr>', {})

-- :ww writes with sudo (temporary)
-- https://github.com/neovim/neovim/issues/1716
-- https://github.com/lambdalisue/suda.vim
-- command! -nargs=0 WriteWithSudo :w !sudo tee % > /dev/null
-- cnoreabbrev ww WriteWithSudo
cmd('cnoreabbrev ww SudaWrite')

-- :bufo closes all open buffers except the current buffer
cmd([[cnoreabbrev bufo %bd\|e#\|bd#<Cr>\|'"']])
