return {
  {
    "AndrewRadev/dsf.vim",
    init = function()
      vim.g.dsf_brackets = "([{<"
      vim.opt.matchpairs:append("<:>")
    end,
  },
}
