return {
  'catppuccin/nvim',
  lazy = false,
  config = function()
    require('catppuccin').setup {
      transparent_background = true,
    }
    vim.cmd.colorscheme 'catppuccin-mocha'
    vim.opt.termguicolors = true
  end,
  name = 'catppuccin',
  priority = 1000,
}
