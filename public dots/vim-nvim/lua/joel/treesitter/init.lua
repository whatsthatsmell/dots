-- stolen from: https://github.com/David-Kunz/treesitter-unit
local ts_utils = require "nvim-treesitter.ts_utils"

local M = {}

local get_master_node = function()
  local node = ts_utils.get_node_at_cursor()
  if node == nil then
    error "No Treesitter parser found."
  end
  local parent = node:parent()
  local root = ts_utils.get_root_for_node(node)
  local start_row = node:start()
  while parent ~= nil and parent ~= root and parent:start() == start_row do
    node = parent
    parent = node:parent()
  end
  return node
end

M.select = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local node = get_master_node()
  ts_utils.update_selection(bufnr, node)
end

M.delete = function(for_change)
  local bufnr = vim.api.nvim_get_current_buf()
  local node = get_master_node()
  local start_row, start_col, end_row, end_col = node:range()
  local replaced = for_change and " " or ""
  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { replaced })
end

M.change = function()
  M.delete(true)
  vim.cmd "startinsert"
end

return M
