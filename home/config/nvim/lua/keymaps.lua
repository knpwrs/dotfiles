--
-- Global Keymaps
--

local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

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

-- Execute macro over lines in visual mode
cmd([[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])
nvim_set_keymap('x', '@', ':<C-u>call ExecuteMacroOverVisualRange()<Cr>', { noremap = true })

-- \, edits the config file.
nvim_set_keymap('n', '<Leader>,', ':tabe $MYVIMRC<Cr>', {})

-- :bufo closes all open buffers except the current buffer
cmd([[cnoreabbrev bufo %bd\|e#\|bd#<Cr>\|'"']])

-- \bd deletes the current buffer
nvim_set_keymap('n', '<Leader>bd', ':bdelete<Cr>', {})

-- \r replaces the word under the cursor
nvim_set_keymap('n', '<Leader>r', ':%s/<C-r><C-w>//g<Left><Left>', {})

-- <C-l> redraws the screen and removes any search highlighting.
nvim_set_keymap('n', '<C-l>', ':nohl<Cr><C-l>', { noremap = true })

-- Do not jump on invocation of *
nvim_set_keymap('n', '*', ':keepjumps normal! mi*`i<Cr>', {})

-- Toggle spellchecking
nvim_set_keymap('', '<Leader>s', ':set spell!<Cr>', { noremap = true })

-- Toggle paste mode
nvim_set_keymap('', '<Leader>P', ':set paste!<Cr>', { noremap = true })

-- Split mappings
nvim_set_keymap('', [[<Leader>-]], ':<C-u>split<Cr>', { noremap = true })
nvim_set_keymap('', [[<Leader>|]], ':<C-u>vsplit<Cr>', { noremap = true })

-- Copy/yank file paths
nvim_set_keymap('n', 'cp', ':let @*=expand("%")<Cr>', {})
nvim_set_keymap('n', 'cP', ':let @*=expand("%:p")<Cr>', {})
nvim_set_keymap('n', 'yp', ':let @"=expand("%")<Cr>', {})
nvim_set_keymap('n', 'yP', ':let @"=expand("%:p")<Cr>', {})

-- Write with sudo (temporary)
-- https://github.com/neovim/neovim/issues/1716
-- https://github.com/lambdalisue/suda.vim
-- command! -nargs=0 WriteWithSudo :w !sudo tee % > /dev/null
-- cnoreabbrev ww WriteWithSudo
cmd('cnoreabbrev ww SudaWrite')
