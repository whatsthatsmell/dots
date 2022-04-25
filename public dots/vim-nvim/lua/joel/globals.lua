-- use '=' in command mode to pretty print returned value
-- Ex: `:lua =vim.api.nvim_get_mode()`
-- P() for in code debugging or vim.pretty_print()
P = function(v)
  print(vim.inspect(v))
  return v
end

-- Debug Notification
-- (value, context_message)
DN = function(v, cm)
  local time = os.date "%H:%M"
  local context_msg = cm or " "
  local msg = context_msg .. " " .. time
  require "notify"(vim.inspect(v), "debug", { title = { "Debug Output", msg } })
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
