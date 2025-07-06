local map = vim.keymap.set

map('n', '<leader>cc', require('custom.utilities.compile_commands').copy_compile_commands, {
    desc = '[C]opy [C]ompile commands to root directory'
})
map('n', '<leader>`', '<CMD>Floaterminal<CR>', {
    desc = 'Toggle Floating Terminal'
})

map('n', '<C-h>', '<C-w><C-h>', {
    desc = 'Move focus to the left window'
})
map('n', '<C-l>', '<C-w><C-l>', {
    desc = 'Move focus to the right window'
})
map('n', '<C-j>', '<C-w><C-j>', {
    desc = 'Move focus to the lower window'
})
map('n', '<C-k>', '<C-w><C-k>', {
    desc = 'Move focus to the upper window'
})
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, {
    desc = 'Open diagnostic [Q]uickfix list'
})
map('t', '<Esc><Esc>', '<C-\\><C-n>', {
    desc = 'Exit terminal mode'
})
map("n", "<C-S-h>", "<C-w>H", {
    desc = "Move window to the left"
})
map("n", "<C-S-l>", "<C-w>L", {
    desc = "Move window to the right"
})
map("n", "<C-S-j>", "<C-w>J", {
    desc = "Move window to the lower"
})
map("n", "<C-S-k>", "<C-w>K", {
    desc = "Move window to the upper"
})
