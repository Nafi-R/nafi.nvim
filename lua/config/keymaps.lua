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
})
map('n', '<C-l>', '<C-w><C-l>', {
  desc = 'Move focus to the right window',
})
map('n', '<C-j>', '<C-w><C-j>', {
  desc = 'Move focus to the lower window',
})
map('n', '<C-k>', '<C-w><C-k>', {
  desc = 'Move focus to the upper window',
})
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, {
  desc = 'Open diagnostic [Q]uickfix list',
})
map('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
})
map('n', '<C-S-h>', '<C-w>H', {
  desc = 'Move window to the left',
})
map('n', '<C-S-l>', '<C-w>L', {
  desc = 'Move window to the right',
})
map('n', '<C-S-j>', '<C-w>J', {
  desc = 'Move window to the lower',
})
map('n', '<C-S-k>', '<C-w>K', {
  desc = 'Move window to the upper',
})
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', '<leader><TAB>', ':bn<CR>')
map('n', '<leader><S-TAB>', ':bp<CR>')
map('n', '<leader>bd', ':bd<CR>', { desc = '[B]uffer [D]elete' })

map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('n', '<leader>\\', require('custom.utilities.splits').open_vertical, {
  desc = '[S]plit [H]orizontally',
})
map('n', '<leader>-', require('custom.utilities.splits').open_horizontal, {
  desc = '[S]plit [V]ertically',
})
map('n', '<leader>wd', '<CMD>close<CR>', {
  desc = 'Close window',
})
map('n', '<leader>cp', '<CMD>CopilotChat<CR>', { desc = 'Open Copilot Panel' })
map('n', '<leader>cm', '<CMD>CopilotChatModels<CR>', { desc = 'Choose Copilot model' })
