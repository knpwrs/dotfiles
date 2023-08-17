return {
  'tamton-aquib/duck.nvim',
  config = function()
    local wk = require('which-key')
    local duck = require('duck')

    wk.register(
      {
        d = {
          name = 'Duck',
          d = { function() duck.hatch() end, 'Hatch Duck' },
          k = { function() duck.cook() end, 'Cook Duck' },
        },
      },
      {
        prefix = '<Leader><Leader>',
      }
    )
  end
}
