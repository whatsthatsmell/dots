local M = {}

function M.is_buffer_empty()
  -- Check whether the current buffer is empty
  return vim.fn.empty(vim.fn.expand "%:t") == 1
end

function M.has_width_gt(cols)
  -- Check if the windows width is greater than a given number of columns
  return vim.fn.winwidth(0) / 2 > cols
end

-- @TODOUA: replace OpenURLUnderCursor from init.lua here:
function M.launch_browser()
  return "Nope, you have not impl'd me yet!"
end

return M
