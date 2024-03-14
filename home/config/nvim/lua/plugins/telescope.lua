local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  keys = {
    { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
    { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    { "<leader>fg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    { "<leader>fG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>fw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
    { "<leader>fW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
    { "<leader>fw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
    { "<leader>fW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>fT", "<cmd>Telescope<cr>", desc = "Built-in Pickers" },
    { "<leader>f=", "<cmd>Telescope spell_suggest<cr>", desc = "Spelling Suggestions" },
  },
}
