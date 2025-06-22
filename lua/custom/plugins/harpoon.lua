return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }
        -- Add to harpoon list
        map("n", "<leader>ha", function() harpoon:list():add() end, { 
            noremap = true,
            silent = true,
            desc = "Add file to harpoon list"
        })
        -- Open harpoon list
        map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {
            noremap = true,
            silent = true,
            desc = "Open harpoon list"
        })

        -- Go to harpoon files
        map("n", "<leader>1", function() harpoon:list():select(1) end, {
            noremap = true,
            silent = true,
            desc = "Go to harpoon file 1"
        })
        map("n", "<leader>2", function() harpoon:list():select(2) end, {
            noremap = true,
            silent = true,
            desc = "Go to harpoon file 2"
        })
        map("n", "<leader>3", function() harpoon:list():select(3) end, {
            noremap = true,
            silent = true,
            desc = "Go to harpoon file 3"
        })
        map("n", "<leader>4", function() harpoon:list():select(4) end, {
            noremap = true,
            silent = true,
            desc = "Go to harpoon file 4"
        })

        -- Go to next and previous harpoon files
        map("n", "<C-S-P>", function() harpoon:list():prev() end, {
            noremap = true,
            silent = true,
            desc = "Go to previous harpoon file"
        })
                   
        map("n", "<C-S-N>", function() harpoon:list():next() end, {
            noremap = true,
            silent = true,
            desc = "Go to next harpoon file"
        })
    end,
}
