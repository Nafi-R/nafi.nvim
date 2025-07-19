return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = ' ', right = '' },
      },
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'lsp_status' },
      },
    }
  end,
}
