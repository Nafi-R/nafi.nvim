return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    -- Only one of these is needed.
    'nvim-telescope/telescope.nvim', -- optional
  },
  config = function()
    local neogit = require 'neogit'
    vim.keymap.set('n', '<leader>go', '<CMD>Neogit kind=floating<CR>', { desc = 'Open Neogit' })
    vim.keymap.set('n', '<leader>gd', '<CMD>Neogit diff kind=floating<CR>', { desc = 'Open Neogit diff' })
    vim.keymap.set('n', '<leader>gb', '<CMD>Neogit branch kind=floating<CR>', { desc = 'Open Neogit diff' })
  end,
}
