local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local action_state = require 'telescope.actions.state'
local previewers = require 'telescope.previewers'
local actions = require 'telescope.actions'

local function open_split(split_cmd)
  local telescope = require 'telescope.builtin'
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  local current_buf = vim.api.nvim_get_current_buf()
  vim.cmd(split_cmd)
  if #buffers == 1 then
    telescope.find_files()
  elseif #buffers == 2 then
    local other_buf = buffers[1].bufnr == current_buf and buffers[2].bufnr or buffers[1].bufnr
    vim.cmd('buffer ' .. other_buf)
  elseif #buffers > 2 then
    telescope.buffers()
  end
end

local function open_terminal_split(split_cmd)
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  local terminal_buffers = {}

  -- Filter terminal buffers
  for _, buf in ipairs(buffers) do
    if buf.name and buf.name:match 'term://' then
      table.insert(terminal_buffers, { buf.bufnr, buf.name })
    end
  end

  if #terminal_buffers == 0 then
    -- No terminal buffers exist, open a new terminal
    vim.cmd(split_cmd .. ' | terminal')
    vim.cmd 'startinsert'
  elseif #terminal_buffers == 1 then
    -- One terminal buffer exists, open a split with it
    vim.cmd(split_cmd)
    vim.cmd('buffer ' .. terminal_buffers[1][1])
    vim.cmd 'startinsert'
  else
    -- Multiple terminal buffers exist, use Telescope to select one
    local term_finder = finders.new_table {
      results = terminal_buffers,
      entry_maker = function(entry)
        return {
          value = entry[1],
          display = entry[2],
          ordinal = entry[2],
        }
      end,
    }
    pickers
      .new({}, {
        prompt_title = 'Select Terminal Buffer',
        finder = term_finder,
        previewer = previewers.new_buffer_previewer {
          define_preview = function(self, entry, status)
            local bufnr = entry.value
            if vim.api.nvim_buf_is_valid(bufnr) then
              -- Set buffer options
              -- vim.api.nvim_buf_set_option(bufnr, 'filetype', 'terminal')

              -- Load buffer content into the preview window
              local preview_bufnr = self.state.bufnr
              vim.api.nvim_buf_set_lines(preview_bufnr, 0, -1, false, vim.api.nvim_buf_get_lines(bufnr, 0, -1, false))
              -- vim.api.nvim_buf_set_option(preview_bufnr, 'syntax', 'on')
            end
          end,
        },
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection and selection.value then
              vim.cmd(split_cmd)
              vim.cmd('buffer ' .. selection.value)
              vim.cmd 'startinsert'
            end
          end)
          return true
        end,
      })
      :find()
  end
end

return {
  open_vertical = function()
    open_split 'vsplit'
  end,
  open_horizontal = function()
    open_split 'split'
  end,
  open_terminal_vertical = function()
    open_terminal_split 'vsplit'
  end,
  open_terminal_horizontal = function()
    open_terminal_split 'split'
  end,
  test_split = function()
    vim.notify('This is a test split function. It does nothing.', vim.log.levels.INFO, { title = 'Test Split' })
  end,
}
