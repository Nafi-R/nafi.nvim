return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  },
  config = function(_, opts)
    require('auto-session').setup(opts)
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    local sessionexit = vim.api.nvim_create_augroup('sessionexit', {
      clear = true,
    })
    -- Save session when leaving neovim
    vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
      group = sessionexit,
      callback = function()
        require('auto-session').auto_save_session()
      end,
    })
  end
}
