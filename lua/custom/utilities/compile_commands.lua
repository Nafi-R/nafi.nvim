return {
    copy_compile_commands = function()
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'
        local conf = require('telescope.config').values
        local root = vim.fn.getcwd()
        local destination_path = root .. '/compile_commands.json'

        pickers.new({}, {
            prompt_title = 'Select compile_commands.json to copy',
            finder = finders.new_oneshot_job({'rg', '-u', '--files', '--glob', '**/compile_commands.json'}, {
                cwd = root
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    if selection and selection[1] then
                        local source_path = selection[1]
                        local command = string.format('cp %s %s', vim.fn.shellescape(source_path),
                            vim.fn.shellescape(destination_path))
                        local result = vim.fn.system(command)
                        if vim.v.shell_error == 0 then
                            print('Successfully copied compile_commands.json to ' .. destination_path)
                        else
                            print('Error copying compile_commands.json: ' .. result)
                        end
                    else
                        print('No compile_commands.json selected.')
                    end
                end)
                return true
            end
        }):find()
    end
}
