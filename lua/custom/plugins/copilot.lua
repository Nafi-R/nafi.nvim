return {
  {
    'github/copilot.vim',
    config = function()
      -- Set semi-transparent inline hints
      vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
        fg = '#555555', -- Adjust color for semi-transparency
        ctermfg = 8,
      })

      -- Clear Copilot suggestions when entering normal mode
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*:n',
        callback = function()
          vim.fn['copilot#Dismiss']()
        end,
      })

      -- Set enterprise GitHub link
      -- vim.g.copilot_enterprise_uri = 'https://DOMAIN.ghe.com'
    end,
  },
  {
    {
      'CopilotC-Nvim/CopilotChat.nvim',
      dependencies = {
        { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
        { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
      },
      build = 'make tiktoken', -- Only on MacOS or Linux
      opts = {},
    },
  },
}
