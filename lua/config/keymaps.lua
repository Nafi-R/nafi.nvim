local map = vim.keymap.set

map('n', '<leader>cc', require('custom.utilities.compile_commands').copy_compile_commands, { desc = '[C]opy [C]ompile commands to root directory' })
