return {
  'catppuccin/nvim',
  lazy = false,
  config = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
  name = 'catppuccin',
  priority = 1000,
}
