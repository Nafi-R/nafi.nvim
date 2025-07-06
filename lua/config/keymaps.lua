local map = vim.keymap.set

vim.keymap.set('n', '<leader>cc', require('custom.utilities.compile_commands').copy_compile_commands, {
  desc = '[C]opy [C]ompile commands to root directory',
})
vim.keymap.set('n', '<leader>`', '<CMD>Floaterminal<CR>', {
  desc = 'Toggle Floating Terminal',
})
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
  desc = 'Move focus to the left window',
})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
  desc = 'Move focus to the right window',
})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
  desc = 'Move focus to the lower window',
})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
  desc = 'Move focus to the upper window',
})
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
  desc = 'Open diagnostic [Q]uickfix list',
})
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
})
vim.keymap.set('n', '<C-S-h>', '<C-w>H', {
  desc = 'Move window to the left',
})
vim.keymap.set('n', '<C-S-l>', '<C-w>L', {
  desc = 'Move window to the right',
})
vim.keymap.set('n', '<C-S-j>', '<C-w>J', {
  desc = 'Move window to the lower',
})
vim.keymap.set('n', '<C-S-k>', '<C-w>K', {
  desc = 'Move window to the upper',
})
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('n', '<TAB>', ':bn<CR>')
vim.keymap.set('n', '<S-TAB>', ':bp<CR>')
vim.keymap.set('n', '<leader>bd', ':bd<CR>')
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
