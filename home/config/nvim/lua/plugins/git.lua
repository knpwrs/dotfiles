return {
  {
    "FabijanZulj/blame.nvim",
    keys = {
      { "<leader>gb", "<cmd>ToggleBlame<cr>", desc = "Toggle Git Blame" },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
  },
}
