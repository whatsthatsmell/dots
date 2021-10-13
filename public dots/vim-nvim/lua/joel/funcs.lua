local utils = require "joel.utils"
-- add current line as task to todoist
-- Using: https://github.com/sachaos/todoist
-- @TODOUA: check latest source for new features like 'Description'
-- @TODOUA: Widen reach beyond markdown
-- @TODOUA: Currently, the Neovim project is hardcoded, fix this
-- @TODOUA: filter dashes '-' for `todoist CLI`, current line can't have a dash!
-- @TODOUA: Allow visual selection to be title?
-- @TODOUA: Telescope integration for selecting projects and/or titles
-- @TODOUA: Support for label, priority, dates, etc. ??

local M = {}
function M.create_task()
  local current_line = vim.api.nvim_get_current_line()
  local content = utils.get_os_command_output({ "todoist", "add", current_line, "-N", "Neovim", "-d", "today" }, "~")
  P("Task Created: " .. current_line)
  return content
end
return M
