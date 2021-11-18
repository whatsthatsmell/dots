-- telescope picker template
local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

function handle_cr(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "mycmd " .. selected[1]
  vim.cmd(cmd)
  actions.close(prompt_bufnr)
end

function next_item(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "mycmd " .. selected[1]
  vim.cmd(cmd)
end

function prev_item(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "mycmd " .. selected[1]
  vim.cmd(cmd)
end

local items = vim.fn.getcompletion("", "source")

local opts = {

  finder = finders.new_table(items),
  sorter = sorters.get_generic_fuzzy_sorter {},

  attach_mappings = function(prompt_bufnr, map)
    map("n", "<CR>", handle_cr)
    map("n", "j", next_item)
    map("n", "k", prev_item)

    map("i", "<CR>", handle_cr)
    map("i", "<C-J>", next_item)
    map("i", "<C-K>", prev_item)

    return true
  end,
}

local my_picker = pickers.new(opts)

my_picker:find()
