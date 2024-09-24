local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "carbonfox"
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 12.0

config.hide_tab_bar_if_only_one_tab = true

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "wsl.exe" }
end

return config
