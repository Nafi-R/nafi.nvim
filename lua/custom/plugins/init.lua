-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- basic setup; you can pass your options here
      require('nvim-tree').setup {
        -- your custom options, e.g.:
        -- auto_close = true,
        -- hijack_cursor = true,
      }

      -- map <leader>e to toggle the tree sidebar
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', {
        desc = 'Toggle NvimTree',
      })
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*', -- use latest stable
    config = function()
      require('toggleterm').setup {
        size = 10, -- 10 lines high
        open_mapping = [[<leader>`]], -- bind <leader>` to toggle
        direction = 'horizontal', -- bottom split
        start_in_insert = true, -- go to insert mode
        insert_mappings = false, -- no mapping in insert mode
        persist_size = true, -- remember last size
      }
    end,
  },
  {
    'folke/snacks.nvim',
    opts = {
      scroll = {
        animate = {
          duration = {
            step = 15,
            total = 250,
          },
          easing = 'linear',
        },
        -- faster animation when repeating scroll after delay
        animate_repeat = {
          delay = 100, -- delay in ms before using the repeat animation
          duration = {
            step = 5,
            total = 50,
          },
          easing = 'linear',
        },
        -- what buffers to animate
        filter = function(buf)
          return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= 'terminal'
        end,
      },
    },
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}
