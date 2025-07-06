return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-telescope/telescope.nvim' },
  event = 'VeryLazy',
  opts = {
    options = {
      icons = true,
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
