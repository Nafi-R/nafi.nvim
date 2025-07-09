local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

map('n', '<leader>cc', require('custom.utilities.compile_commands').copy_compile_commands, {
  desc = '[C]opy [C]ompile commands to root directory',
})
map('n', '<leader>`', '<CMD>Floaterminal<CR>', {
  desc = 'Toggle Floating Terminal',
})
map('n', '<C-h>', '<C-w><C-h>', {
  desc = 'Move focus to the left window',
  noremap = true,
})
map('n', '<C-l>', '<C-w><C-l>', {
  desc = 'Move focus to the right window',
  noremap = true,
})
map('n', '<C-j>', '<C-w><C-j>', {
  desc = 'Move focus to the lower window',
  noremap = true,
})
map('n', '<C-k>', '<C-w><C-k>', {
  desc = 'Move focus to the upper window',
  noremap = true,
})

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, {
  desc = 'Open diagnostic [Q]uickfix list',
})
-- Exit terminal mode with double Esc
map('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
})
-- Move windows with Alt + hjkl
map('n', '<A-h>', '<C-w>H', {
  desc = 'Move window to the left',
})
map('n', '<A-l>', '<C-w>L', {
  desc = 'Move window to the right',
})
map('n', '<A-j>', '<C-w>J', {
  desc = 'Move window to the lower',
})
map('n', '<A-k>', '<C-w>K', {
  desc = 'Move window to the upper',
})
-- Resize splits with Alt + arrow keys
map('n', '<C-Right>', '<C-w><', {
  desc = 'Resize split Right',
})
map('n', '<C-Left>', '<C-w>>', {
  desc = 'Resize split Left',
})
map('n', '<C-Up>', '<C-w>-', {
  desc = 'Resize split Up',
})
map('n', '<C-Down>', '<C-w>+', {
  desc = 'Resize split Down',
})

-- Move lines up and down in visual mode
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Indent text in visual mode without losing place
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Buffer management
map('n', '<leader><TAB>', '<CMD>bn<CR>')
map('n', '<leader><S-TAB>', '<CMD>bp<CR>')
map('n', '<leader>bd', '<CMD>bd<CR>', { desc = '[B]uffer [D]elete' })
map('n', '<leader>bo', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, b in ipairs(buffers) do
    if b ~= bufnr and vim.api.nvim_buf_is_loaded(b) then
      vim.api.nvim_buf_delete(b, {})
    end
  end
end, { desc = '[B]uffer delete [o]thers' })
map('n', '<leader>wo', '<CMD>only<CR>', { desc = '[W]indow close [O]ther' })
map('n', '<leader>q', '<CMD>close<CR>', {
  desc = 'Close window',
})

map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz', { noremap = true })
map('n', '<C-u>', '<C-u>zz', { noremap = true })
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('n', '<leader>\\', require('custom.utilities.splits').open_vertical, {
  desc = '[S]plit [H]orizontally',
})
map('n', '<leader>-', require('custom.utilities.splits').open_horizontal, {
  desc = '[S]plit [V]ertically',
})

map('n', '<leader>t\\', require('custom.utilities.splits').open_terminal_vertical, {
  desc = '[S]plit [H]orizontally',
})
map('n', '<leader>t-', require('custom.utilities.splits').open_terminal_horizontal, {
  desc = '[S]plit [V]ertically',
})

map('n', '<leader>cp', '<CMD>CopilotChat<CR>', { desc = 'Open Copilot Panel' })
map('n', '<leader>cm', '<CMD>CopilotChatModels<CR>', { desc = 'Choose Copilot model' })
