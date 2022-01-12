vim.g.slime_target = 'tmux'
vim.g.slime_paste_file = vim.fn.tempname()
vim.g.slim_bracketed_paste = 1
vim.g.slime_default_config = {
  -- Lua doesn't have a string split function!
  socket_name = vim.api.nvim_eval('get(split($TMUX, ","), 0)'),
  target_pane = '{top-right}',
}
