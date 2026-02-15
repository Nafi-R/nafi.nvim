return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  config = function()
    local filetypes = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim',
      'vimdoc' }
    local ts = require('nvim-treesitter')
    ts.setup()
    ts.install(filetypes)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function() vim.treesitter.start() end,
    })
  end,
}
