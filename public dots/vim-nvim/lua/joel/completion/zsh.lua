-- Now using cmp-zsh: https://github.com/tamago324/cmp-zsh!

-- Thank you CantoroMC for the below solution I was using
-- https://github.com/CantoroMC/dotfiles/blob/e2ae91b725f09cdd66d93d97f4b995d48f620e3d/neovim/.config/nvim/lua/mc/packer/nvim-cmp/zsh.lua#L1
local cmp = require "cmp"
local Job = require "plenary.job"
local source = {}

source.new = function()
  local self = setmetatable({}, { __index = source })
  return self
end

function source:get_debug_name()
  return "zsh"
end

source.is_available = function()
  if vim.o.filetype == "zsh" then
    return true
  else
    return false
  end
end

function source:_collect(input)
  local results = {}
  self.capture = string.format("%s/lua/joel/completion/cmp_zsh_capture.zsh", vim.fn.stdpath "config")

  Job
    :new({
      command = "zsh",
      args = { self.capture, input },
      cwd = vim.fn.getcwd(),

      on_stdout = function(_, data)
        local pieces = vim.split(data, " -- ", true)
        if #pieces > 1 then
          table.insert(results, {
            label = pieces[1],
            user_data = pieces[2],
            documentation = pieces[2],
            kind = cmp.lsp.CompletionItemKind.EnumMember,
          })
        else
          table.insert(results, {
            label = pieces[1],
            kind = cmp.lsp.CompletionItemKind.Function,
          })
        end
      end,
      on_exit = function()
        return
      end,
    })
    :sync()

  return results
end

function source:complete(params, callback)
  if not vim.fn.executable "zsh" then
    return callback()
  end

  callback(self:_collect(params.context.cursor_before_line))
end

return source
