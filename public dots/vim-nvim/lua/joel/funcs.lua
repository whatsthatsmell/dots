local Job = require "plenary.job"
local utils = require "joel.utils"

-- Create todoist task using currect selection (Neovim project and Neovim label)
-- Using(for now): https://github.com/sachaos/todoist
-- @TODOUA: possibly go directly to Todoist API to fill gaps in sachaos(as temp solve): https://developer.todoist.com/sync
-- -- -- -- -- sections, description etc.
-- -- -- -- -- sections possibly available all or in part in master: https://github.com/sachaos/todoist/pull/146
-- @TODOUA: Scorched Earth: create a CLI or contrib to sachaos'
-- @TODOUA: Currently, priority is hardcoded to 3, Fix this & add picker for fields
-- @TODOUA: Update to use more updated todoist CLI API
local M = {}
function M.create_todoist_task(opts)
  opts = opts or {}
  -- Default: My 'Neovim' project & 'Neovim' label
  local project_id = opts.proj_id or 2251750391
  local label_id = opts.label_id or "Neovim"
  local current_line = vim.fn.getline "."
  local first_char = vim.fn.col "v"
  local last_char = vim.fn.col "."
  local selection = string.sub(current_line, first_char, last_char)

  local identifier = "Neovim"
  if project_id ~= 2251750391 then identifier = "Personal" end
  -- @TODOUA: fix for upstream breaking change once todoist CLI updates accordingly...
  -- Todoist Sync API replaced `date str w/ 'Due'`. todoist CLI needs to fix for breaking change.
  -- There is a PR: https://github.com/sachaos/todoist/pull/205
  -- For now, you can't set a (due)date. Task still created but missing due date.
  local ret_val = utils.get_os_command_output(
    { "todoist", "add", selection, "-P", project_id, "-d", "today", "-L", label_id, "-p", "3" },
    "~"
  )

  require "notify"(identifier .. " Task Added: " .. selection, "info", { title = "Todoist" })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "m", true)

  return ret_val
end

function M.notify_current_datetime()
  local dt = vim.fn.strftime "%c"
  require "notify"("Current Date Time: " .. dt, "info", { title = "Date & Time" })
end

-- @TODOUA: is this a util? Should it be made into one?
function M.yank_current_file_name()
  local file_name = vim.api.nvim_buf_get_name(0)
  local input_pipe = vim.loop.new_pipe(false)

  local yanker = Job:new {
    writer = input_pipe,
    command = "pbcopy",
  }

  -- @TODOUA: This works perfectly but double-check if it could be better(less)
  yanker:start()
  input_pipe:write(file_name)
  input_pipe:close()
  yanker:shutdown()

  require "notify"("Yanked: " .. file_name, "info", { title = "File Name Yanker", timeout = 1000 })
end

-- clear nvim-notify notifications history
function M.clear_notification_history()
  local choice = vim.fn.confirm("Clear Notification History?", "&Yes\n&No\n&Cancel")
  if choice == 1 then
    R "notify"
    print "Notification History Cleared"
  else
    print "Notification History Remains"
  end
end

-- cliclick goodness
-- click notification banner. MacOS specific - 2560x1440
function M.click_banner_notification()
  local _ = utils.get_os_command_output({ "cliclick", "c:2525,30" }, "~")
  return _
end

-- cliclick  move pointer off top Mac sys menu - MacOS specific - 2560x1440
-- most annoying issue in Big Sur!!!!
function M.move_pointer_off_menu()
  local _ = utils.get_os_command_output({ "cliclick", "m:1300,95" }, "~")
  return _
end
-- end of cliclick goodness

-- toggle boolean word - true/false
-- @TODOUA: Try https://github.com/nguyenvukhang/nvim-toggler/blob/main/lua/nvim-toggler.lua
function M.toggle_bool(args)
  if args.word == "true" then
    vim.cmd [[norm ciwfalse]]
  elseif args.word == "false" then
    vim.cmd [[norm ciwtrue]]
  else
    print "Word under cursor needs to be 'true' or 'false"
  end
end

return M
