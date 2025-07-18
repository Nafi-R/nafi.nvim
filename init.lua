vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.cmdheight = 0

local number_toggle = vim.api.nvim_create_augroup('numbertoggle', {
  clear = true,
})

-- Auto command to increase the command height when in command mode
vim.api.nvim_create_autocmd('CmdlineEnter', {
  group = number_toggle,
  callback = function()
    vim.opt.cmdheight = 1
  end,
})

-- Auto command to decrease the command height when leaving command mode
vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = number_toggle,
  callback = function()
    vim.opt.cmdheight = 0
  end,
})

-- Auto-commands to switch between relative and absolute line numbers
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  group = number_toggle,
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  group = number_toggle,
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
})

-- Fix: Also handle <C-c> exiting insert mode
vim.api.nvim_create_autocmd('ModeChanged', {
  group = number_toggle,
  pattern = 'i:*',
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = true
    end
  end,
})
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
    clear = true,
  }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Call the autosource function after its definition

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
local auto_source_folders = {
  'config',
  'custom/utilities',
}

local autosource = function()
  for _, folder in ipairs(auto_source_folders) do
    local path = vim.fn.stdpath 'config' .. '/lua/' .. folder
    local files = vim.fn.glob(path .. '/*.lua', false, true)
    for _, file in ipairs(files) do
      local name = vim.fn.fnamemodify(file, ':t:r')
      require(folder .. '.' .. name)
    end
  end

  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.lua',
    callback = function(args)
      --- Your code here
      local file = args.file
      for _, folder in ipairs(auto_source_folders) do
        local match_path = 'lua/' .. folder .. '/'
        if file:match(match_path) then
          local name = vim.fn.fnamemodify(file, ':t:r')
          local require_path = (folder .. '.' .. name):gsub('/', '.')
          package.loaded[require_path] = nil
          require(require_path)
          vim.notify('Reloading module: ' .. require_path, vim.log.levels.INFO)
        end
      end
    end,
  })
end

autosource()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
