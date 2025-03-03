return {
  {
    "AndrewRadev/dsf.vim",
    init = function()
      vim.g.dsf_brackets = "([{<"
      vim.opt.matchpairs:append("<:>")
    end,
  },
  {
    "folke/flash.nvim",
    keys = {
      -- disable the default flash keymap
      { "s", mode = { "n", "x", "o" }, false },
    },
    opts = {
      modes = {
        search = {
          enabled = true,
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 200,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
    },
  },
}
