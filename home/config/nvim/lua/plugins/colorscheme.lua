return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    on_colors = function(colors)
      colors.bg = "#000000"
      colors.bg_dark = "#000000"
      colors.bg_sidebar = "#000000"
    end,
  },
}
