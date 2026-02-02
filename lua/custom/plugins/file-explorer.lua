-- return {
--   'stevearc/oil.nvim',
--   ---@module 'oil'
--   ---@type oil.SetupOpts
--   opts = {
--     delete_to_trash = true, -- Use the system trash for deletions
--   },
--   -- Optional dependencies
--   dependencies = { { 'echasnovski/mini.icons', opts = {} } },
--   keys = {
--     { '<leader>e', '<cmd>Oil --float<cr>', desc = 'Open Oil' },
--   },
--   -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
--   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
--   lazy = false,
-- }

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                    -- neo-tree will lazily load itself
    keys = {
      {
        '<leader>e', '<CMD>Neotree toggle=true reveal=true<CR>', desc = 'Open file explorer'
      },
    },
    opts = {
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.opt_local.number = true
            vim.opt_local.relativenumber = true
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        window = {
          mappings = {
            ['-'] = 'navigate_up',
          },
        },
      },
    },
  },
}
