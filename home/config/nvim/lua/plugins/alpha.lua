local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'

dashboard.section.header.val = {
  [[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
  [[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
  [[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
  [[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
  [[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
  [[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}
dashboard.section.header.opts.hl = 'deviconhtml'

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = 'warningmsg'
  b.opts.hl_shortcut = 'warningmsg'
  return b
end

dashboard.section.buttons.val = {
  button('e', '  New file', ':ene <Bar> startinsert <Cr>'),
  button('<Leader>ff', '  Find file'),
  button('<Leader>fg', '  Live grep'),
  button('q', '  Quit NVIM', ':qa<Cr>'),
}

dashboard.opts.opts.noautocmd = true

dashboard.section.footer.val = 'Soli Deo Gloria'
dashboard.section.footer.opts.hl = 'msgarea'

alpha.setup(dashboard.opts)
