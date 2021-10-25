local function alert(body)
  require "notify"(body, "info", { title = "Buffer API Demo" })
end

-- alert "Code Smell"

local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, 3, 0)
-- alert(buffer_lines)

local mark_pos = vim.api.nvim_buf_get_mark(0, "t")
-- alert(vim.inspect(mark_pos))

local shift_width = vim.api.nvim_buf_get_option(0, "shiftwidth")
-- alert(vim.inspect(shift_width))

local file_name = vim.api.nvim_buf_get_name(0)
alert(file_name)
