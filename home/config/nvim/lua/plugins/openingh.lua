return {
  {
    "Almo7aya/openingh.nvim",
    keys = {
      { "<leader>gr", ":OpenInGHRepo<cr>", desc = "Open Repo" },
      { "<leader>gcr", ":OpenInGHRepo+<cr>", desc = "Copy URL to Repo" },
      { "<leader>gf", ":OpenInGHFile!<cr>", desc = "Open File in Repo (Current Commit)" },
      { "<leader>gcf", ":OpenInGHFile!+<cr>", desc = "Copy URL to File in Repo (Current Commit)" },
      { "<leader>gf", ":OpenInGHFile!<cr>", desc = "Open File in Repo (Current Commit)", mode = "v" },
      { "<leader>gcf", ":OpenInGHFile!+<cr>", desc = "Copy URL to File in Repo (Current Commit)", mode = "v" },
      { "<leader>gF", ":OpenInGHFile<cr>", desc = "Open File in Repo" },
      { "<leader>gcF", ":OpenInGHFile+<cr>", desc = "Copy URL to File in Repo" },
      { "<leader>gF", ":OpenInGHFile<cr>", desc = "Open File in Repo", mode = "v" },
      { "<leader>gcF", ":OpenInGHFile+<cr>", desc = "Copy URL to File in Repo", mode = "v" },
    },
  },
}
