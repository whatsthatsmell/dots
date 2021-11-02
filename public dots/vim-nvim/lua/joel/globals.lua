P = function(v)
  print(vim.inspect(v))
  return v
end

PN = function(v)
  require "notify"(vim.inspect(v), "debug", { title = "Debug Output" })
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
