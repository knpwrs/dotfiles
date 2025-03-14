-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Disable default lazy keymap
vim.keymap.del("n", "<leader>l")

-- Do not jump on invocation of *
vim.keymap.set("n", "*", ":keepjumps normal! mi*`i<Cr>")

-- Execute macro over lines in visual mode
vim.cmd([[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])
vim.keymap.set("x", "@", ":<C-u>call ExecuteMacroOverVisualRange()<Cr>", { noremap = true })

vim.keymap.set("n", "<leader>y", '"*y', { desc = "Yank to System Clipboard" })
vim.keymap.set("v", "<leader>y", '"*y', { desc = "Yank to System Clipboard" })
vim.keymap.set("n", "cp", ':let @*=expand("%:.")<cr>', { desc = "Copy Relative File Path to System Clipboard" })
vim.keymap.set("n", "cP", ':let @*=expand("%:p")<cr>', { desc = "Copy Absolute File Path to System Clipboard" })
vim.keymap.set("n", "yp", ':let @"=expand("%:.")<cr>', { desc = "Yank Relative File Path" })
vim.keymap.set("n", "yP", ':let @"=expand("%:p")<cr>', { desc = "Yank Absolute File Path" })
