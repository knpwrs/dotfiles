return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>fg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>fG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    },
  },
}
