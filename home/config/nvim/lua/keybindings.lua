--
-- Global Keybindings
--

local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

-- Close quickfix if in quickfix
nvim_set_keymap('n', '<C-d>', '&bt ==# "quickfix" ? ":ccl<CR>" : "<C-d>"', { noremap = true, expr = true })

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
nvim_set_keymap('n', '<C-n>', ':call NumberToggle()<CR>', { noremap = true })

-- Execute macro over lines in visual mode
cmd([[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])
nvim_set_keymap('x', '@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>', { noremap = true })

-- \, edits the config file.
nvim_set_keymap('n', '<Leader>,', ':tabe $MYVIMRC<CR>', {})

-- :bufo closes all open buffers except the current buffer
cmd([[cnoreabbrev bufo %bd\|e#\|bd#<CR>\|'"']])

-- \r replaces the word under the cursor
nvim_set_keymap('n', '<Leader>r', ':%s/<C-r><C-w>//g<Left><Left>', {})

-- <C-l> redraws the screen and removes any search highlighting.
nvim_set_keymap('n', '<C-l>', ':nohl<CR><C-l>', { noremap = true })

-- Do not jump on invocation of *
nvim_set_keymap('n', '*', ':keepjumps normal! mi*`i<CR>', {})

-- Toggle spellchecking
nvim_set_keymap('', '<Leader>s', ':set spell!<CR>', { noremap = true })

-- Toggle paste mode
nvim_set_keymap('', '<Leader>P', ':set paste!<CR>', { noremap = true })

-- Split mappings
nvim_set_keymap('', [[<Leader>-]], ':<C-u>split<CR>', { noremap = true })
nvim_set_keymap('', [[<Leader>|]], ':<C-u>vsplit<CR>', { noremap = true })

-- Copy/yank file paths
nvim_set_keymap('n', 'cp', ':let @*=expand("%")<CR>', {})
nvim_set_keymap('n', 'cP', ':let @*=expand("%:p")<CR>', {})
nvim_set_keymap('n', 'yp', ':let @"=expand("%")<CR>', {})
nvim_set_keymap('n', 'yP', ':let @"=expand("%:p")<CR>', {})

-- Write with sudo (temporary)
-- https://github.com/neovim/neovim/issues/1716
-- https://github.com/lambdalisue/suda.vim
-- command! -nargs=0 WriteWithSudo :w !sudo tee % > /dev/null
-- cnoreabbrev ww WriteWithSudo
cmd('cnoreabbrev ww SudaWrite')
