local gps = require('nvim-gps')

require('lualine').setup({
  options = {
    theme = 'catppuccino',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      {
        'filename',
        path = 1,
      },
      {
        gps.get_location,
        condition = gps.is_available,
      },
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 1,
      },
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nvim-tree'},
})
