local utils = require "joel.utils"
-- add current line as task to todoist
-- Using: https://github.com/sachaos/todoist
-- @TODOUA: check latest source for new features like 'Description'
-- @TODOUA: Widen reach beyond markdown
-- @TODOUA: Currently, the Neovim project is hardcoded, fix this

-- @TODOUA: Allow visual selection to be title? with...
-- @TODOUA: ...Telescope integration for selecting projects and/or titles

-- @TODOUA: Support for label, priority, dates, etc. ??
-- -- Right now, the label 'Neovim' is hardcoded by its ID
-- -- Right now, priority 3 is hardcoded
-- @TODOUA: Note to self: Maybe create a temp project like Inbox but only from here
-- -- -- This is already that. But, it might keep me up at night that it isn't really

local M = {}
function M.create_todoist_task()
  local current_line = vim.trim(string.gsub(vim.api.nvim_get_current_line(), "-", ""))
  local content = utils.get_os_command_output(
    { "todoist", "add", current_line, "-N", "Neovim", "-d", "today", "-L", "2154624877", "-p", "3" },
    "~"
  )

  require "notify"("Task Added: " .. current_line, "info", { title = "Todoist" })
  return content
end
return M
