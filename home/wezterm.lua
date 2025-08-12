local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.color_scheme = "tokyonight_night"
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 12.0

-- UI
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = true

-- Windows
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "wsl.exe" }
end

-- Misc
config.automatically_reload_config = true

-- Keys
config.keys = {
  {
    key = "k",
    mods = "CMD",
    action = wezterm.action.SendKey({ key = "l", mods = "CTRL" }),
  },
  {
    key = "Enter",
    mods = "SHIFT",
    action = wezterm.action.SendString("\n"),
  },
}

return config
