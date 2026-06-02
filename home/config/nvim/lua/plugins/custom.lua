return {
  "ku1ik/vim-pasta",
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
  "tmux-plugins/vim-tmux-focus-events",
  "tommcdo/vim-exchange",
  "tpope/vim-abolish",
  "tpope/vim-eunuch",
  "tpope/vim-sleuth",
  {
    "barrett-ruth/import-cost.nvim",
    build = "sh install.sh npm",
    init = function()
      vim.g.import_cost = { package_manager = "npm" }
    end,
  },
}
