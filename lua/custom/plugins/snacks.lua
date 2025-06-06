return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = { {
    '<leader>e',
    function()
      require('snacks').explorer()
    end,
    desc = 'Toggle Snacks Explorer',
  } },
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = {
      enabled = true,
    },
    dashboard = {
      enabled = true,
    },
    -- @Class snacks.Config
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    indent = {
      enabled = true,
    },
    input = {
      enabled = true,
    },
    picker = {
      enabled = true,
    },
    notifier = {
      enabled = true,
    },
    quickfile = {
      enabled = true,
    },
    scope = {
      enabled = true,
    },
    scroll = {
      enabled = false,
    },
    statuscolumn = {
      enabled = true,
    },
    words = {
      enabled = true,
    },
  },
}
