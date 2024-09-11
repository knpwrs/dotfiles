return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>fG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    },
  },
}
