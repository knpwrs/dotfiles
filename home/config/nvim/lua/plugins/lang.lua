return {
  'hail2u/vim-css3-syntax',
  'mattn/emmet-vim',
  {
    'plasticboy/vim-markdown',
    init = function()
      vim.g.vim_markdown_new_list_item_indent = 2
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_folding_level = 6
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_fenced_languages = {
        'js=javascript',
        'rb=ruby',
        'rs=rust',
        'ts=typescript',
        'py=python',
      }
    end,
  },
  {
    'rust-lang/rust.vim',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
