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
}
