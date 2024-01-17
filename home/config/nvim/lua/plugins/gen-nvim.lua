return {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "zephyr",
    },
    keys = {
      { "<leader>agg", ":Gen Generate<cr>", desc = "Generate" },
      { "<leader>agc", ":Gen Chat<cr>", desc = "Chat" },
      { "<leader>ags", ":Gen Summarize<cr>", mode = "v", desc = "Summarize" },
      { "<leader>aga", ":Gen Ask<cr>", mode = "v", desc = "Ask" },
      { "<leader>age", ":Gen Explain<cr>", mode = "v", desc = "Explain Code" },
      { "<leader>att", ":Gen Change<cr>", mode = "v", desc = "Change Text" },
      { "<leader>atg", ":Gen Enhance_Grammar_Spelling<cr>", mode = "v", desc = "Enhance Grammar and Spelling" },
      { "<leader>atw", ":Gen Enhance_Wording<cr>", mode = "v", desc = "Enhance Wording" },
      { "<leader>atc", ":Gen Make_Concise<cr>", mode = "v", desc = "Make Concise" },
      { "<leader>acr", ":Gen Review_Code<cr>", mode = "v", desc = "Review Code" },
      { "<leader>ace", ":Gen Enhance_Code<cr>", mode = "v", desc = "Enhance Code" },
      { "<leader>acc", ":Gen Change_Code<cr>", mode = "v", desc = "Change Code" },
    },
    config = function()
      require("gen").prompts["Explain"] = {
        prompt = "Explain the following code in plain English:\n$text",
        replace = false,
      }
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>a"] = { name = "+ai" },
      },
    },
  },
}
