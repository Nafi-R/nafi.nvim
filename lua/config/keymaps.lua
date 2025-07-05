local map = vim.keymap.set

map('n', '<leader>cc', require('custom.utilities.compile_commands').copy_compile_commands, { desc = '[C]opy [C]ompile commands to root directory' })
map('n', '<esc><esc>', '<C-\\><C-n>', { desc = 'Exit to normal mode' })
map('n', '<leader>`', '<CMD>Floaterminal<CR>', { desc = 'Toggle Floating Terminal' })

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
