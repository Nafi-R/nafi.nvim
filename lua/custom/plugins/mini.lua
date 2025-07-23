return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  lazy = false,
  opts = {
    cursor = {
      enabled = true,
    },
    scroll = {
      enabled = true,
    },
  },
  config = function()
    require('mini.ai').setup {
      n_lines = 500,
    }
    -- Surround plugin
    require('mini.surround').setup()
  end,
}
