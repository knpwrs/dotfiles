local nvim_set_keymap = vim.api.nvim_set_keymap

vim.g.grepper = {
  tools = {'rg', 'git'},
}

nvim_set_keymap('n', '<Leader>g', ':Grepper<CR>', { noremap = true })
nvim_set_keymap('n', '<Leader>G', ':Grepper -buffers<CR>', { noremap = true })
nvim_set_keymap('n', 'gs', '<plug>(GrepperOperator)', {})
nvim_set_keymap('x', 'gs', '<plug>(GrepperOperator)', {})
nvim_set_keymap('n', '<Leader>*', ':Grepper -cword -noprompt<CR>', { noremap = true })
