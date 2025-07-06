local function open_split(split_cmd)
  local telescope = require 'telescope.builtin'
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  if #buffers > 1 then
    vim.cmd(split_cmd)
    telescope.buffers()
  else
    vim.cmd(split_cmd)
  end
end

return {
  open_vertical = function()
    open_split 'vsplit'
  end,
  open_horizontal = function()
    open_split 'split'
  end,
}
