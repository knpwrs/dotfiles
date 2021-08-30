local gsa = require('gitsigns.actions')
local wk = require('which-key')

require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 250,
  },
}

wk.register(
  {
    ['[h'] = { function() gsa.prev_hunk() end, 'Previous Git Hunk' },
    [']h'] = { function() gsa.next_hunk() end, 'Next Git Hunk' },
  }
)

wk.register(
  {
    h = {
      name = 'Git Hunks',
      s = { function() gsa.stage_hunk() end, 'Stage Hunk' },
      u = { function() gsa.undo_stage_hunk() end, 'Unstage Hunk' },
      r = { function() gsa.reset_hunk() end, 'Reset Hunk' },
      R = { function() gsa.reset_buffer() end, 'Reset Buffer' },
      p = { function() gsa.preview_hunk() end, 'Preview Hunk' },
    },
  },
  {
    prefix = '<Leader>',
  }
)

wk.register(
  {
    h = {
      name = 'Git Hunks',
      s = { function() gsa.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, 'Stage Hunks' },
      r = { function() gsa.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, 'Reset Hunks' },
    },
  },
  {
    prefix = '<Leader>',
    mode = 'v',
  }
)

wk.register(
  {
    i = {
      h = { function() gsa.select_hunk() end, 'Hunk' },
    },
  },
  {
    mode = 'o',
  }
)

wk.register(
  {
    i = {
      h = { function() gsa.select_hunk() end, 'Hunk' },
    },
  },
  {
    mode = 'x',
  }
)
