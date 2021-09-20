vim.cmd [[packadd nvim-web-devicons]]
local gl = require "galaxyline"
local utils = require "joel.utils"
local condition = require "galaxyline.condition"
local diagnostic = require "galaxyline.providers.diagnostic"

local gls = gl.section
gl.short_line_list = { "packer" }

local colors = {
  bg = "#282c34",
  fg = "#aab2bf",
  section_bg = "#38393f",
  blue = "#61afef",
  green = "#98c379",
  purple = "#c678dd",
  orange = "#e5c07b",
  red1 = "#e06c75",
  red2 = "#be5046",
  yellow = "#e5c07b",
  gray1 = "#5c6370",
  gray2 = "#2c323d",
  gray3 = "#3e4452",
  darkgrey = "#5c6370",
  grey = "#848586",
  middlegrey = "#8791A5",
  dodgerblue = "#1e90ff",
  brightgreen = "#96e362",
}

-- Local helper functions
local buffer_not_empty = function()
  return not utils.is_buffer_empty()
end

local checkwidth = function()
  return utils.has_width_gt(35) and buffer_not_empty()
end

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value[1] == val then
      return true
    end
  end
  return false
end

local mode_color = function()
  local mode_colors = {
    [110] = colors.brightgreen,
    [105] = colors.blue,
    [99] = colors.green,
    [116] = colors.blue,
    [118] = colors.dodgerblue,
    [22] = colors.dodgerblue,
    [86] = colors.dodgerblue,
    [82] = colors.red1,
    [115] = colors.red1,
    [83] = colors.red1,
  }

  local color = mode_colors[vim.fn.mode():byte()]
  if color ~= nil then
    return color
  else
    return colors.purple
  end
end

local function file_readonly()
  if vim.bo.filetype == "help" then
    return " ﬤ "
  end
  if vim.bo.readonly == true then
    return "  "
  end
  return ""
end

local function get_current_file_name()
  local file = vim.fn.expand "%:p:."
  if vim.fn.empty(file) == 1 then
    return ""
  end
  if string.len(file_readonly()) ~= 0 then
    return file .. file_readonly()
  end
  if vim.bo.modifiable then
    if vim.bo.modified then
      return file .. "  "
    end
  end
  return file .. " "
end

local function get_basename(file)
  return file:match "^.+/(.+)$"
end

local GetGitRoot = function()
  local git_dir = require("galaxyline.providers.vcs").get_git_dir()
  if not git_dir then
    return ""
  end

  local git_root = git_dir:gsub("/.git/?$", "")
  return get_basename(git_root)
end

local LspStatus = function()
  if #vim.lsp.get_active_clients() > 0 then
    return require("lsp-status").status()
  end
  return ""
end

local LspCheckDiagnostics = function()
  if
    #vim.lsp.get_active_clients() > 0
    and diagnostic.get_diagnostic_error() == nil
    and diagnostic.get_diagnostic_warn() == nil
    and diagnostic.get_diagnostic_info() == nil
    and require("lsp-status").status() == " "
  then
    return " "
  end
  return ""
end

-- Left side
gls.left[1] = {
  ViMode = {
    provider = function()
      local aliases = {
        [110] = "Neoim",
        [105] = "INSERT",
        [99] = "COMMAND",
        [116] = "TERMINAL",
        [118] = "VISUAL",
        [22] = "V-BLOCK",
        [86] = "V-LINE",
        [82] = "REPLACE",
        [115] = "SELECT",
        [83] = "S-LINE",
      }
      vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode_color())
      local alias = aliases[vim.fn.mode():byte()]
      local mode
      if alias ~= nil then
        if utils.has_width_gt(35) then
          mode = alias
        else
          mode = alias:sub(1, 1)
        end
      else
        mode = vim.fn.mode():byte()
      end
      return "  " .. mode .. " "
    end,
    highlight = { colors.bg, colors.bg, "bold" },
  },
}
gls.left[2] = {
  FileIcon = {
    provider = {
      function()
        return "  "
      end,
      "FileIcon",
    },
    condition = buffer_not_empty,
    highlight = {
      require("galaxyline.providers.fileinfo").get_file_icon,
      colors.section_bg,
    },
  },
}
gls.left[3] = {
  FileName = {
    provider = get_current_file_name,
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.section_bg },
    separator = "",
    separator_highlight = { colors.section_bg, colors.bg },
  },
}

gls.left[5] = {
  DiagnosticsCheck = {
    provider = { LspCheckDiagnostics },
    highlight = { colors.middlegrey, colors.bg },
  },
}

gls.left[6] = {
  Space = {
    provider = function()
      return " "
    end,
    highlight = { colors.section_bg, colors.bg },
  },
}

gls.left[7] = {
  DiagnosticError = {
    provider = { "DiagnosticError" },
    icon = " ",
    highlight = { colors.red1, colors.bg },
  },
}

gls.left[8] = {
  Space = {
    provider = function()
      return " "
    end,
    highlight = { colors.section_bg, colors.bg },
  },
}

gls.left[11] = {
  DiagnosticWarn = {
    provider = { "DiagnosticWarn" },
    icon = " ",
    highlight = { colors.yellow, colors.bg },
  },
}
gls.left[12] = {
  Space = {
    provider = function()
      return " "
    end,
    highlight = { colors.section_bg, colors.bg },
  },
}
gls.left[13] = {
  DiagnosticHint = {
    provider = { "DiagnosticHint" },
    icon = " ",
    highlight = { colors.blue, colors.bg },
  },
}

gls.right[1] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = "+",
    highlight = { colors.green, colors.bg },
    separator = " ",
    separator_highlight = { colors.section_bg, colors.bg },
  },
}
gls.right[2] = {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "~",
    highlight = { colors.orange, colors.bg },
  },
}
gls.right[3] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = "-",
    highlight = { colors.red1, colors.bg },
  },
}

gls.right[4] = {
  Space = {
    provider = function()
      return " "
    end,
    highlight = { colors.section_bg, colors.bg },
  },
}

gls.right[5] = {
  BufferNumber = {
    -- provider = "BufferNumber",
    -- Custom provider fixes (overrides): /lua/galaxyline/provider_buffer.lua#L36
    -- https://git.io/Ju7Xa - not sure why they return the index not bufnr?
    provider = function()
      return vim.api.nvim_win_get_buf(0)
    end,
    icon = "﬘ ",
    highlight = { colors.dodgerblue, colors.bg },
  },
}

gls.right[6] = {
  Space = {
    provider = function()
      return " "
    end,
    highlight = { colors.section_bg, colors.bg },
  },
}

gls.right[7] = {
  GitBranch = {
    provider = {
      function()
        return " "
      end,
      "GitBranch",
    },
    condition = condition.check_git_workspace,
    highlight = { colors.middlegrey, colors.bg },
  },
}

gls.right[8] = {
  GitRoot = {
    provider = { GetGitRoot },
    condition = function()
      return utils.has_width_gt(50) and condition.check_git_workspace
    end,
    highlight = { colors.fg, colors.bg },
    separator = " ",
    separator_highlight = { colors.middlegrey, colors.bg },
  },
}

gls.right[9] = {
  LineColumn = {
    provider = "LineColumn",
    highlight = { colors.fg, colors.bg },
    separator = " ",
    separator_highlight = { colors.middlegrey, colors.bg },
  },
}

-- Short status line
gls.short_line_left[1] = {
  FileIcon = {
    provider = {
      function()
        return "  "
      end,
      "FileIcon",
    },
    condition = function()
      return buffer_not_empty and has_value(gl.short_line_list, vim.bo.filetype)
    end,
    highlight = {
      require("galaxyline.providers.fileinfo").get_file_icon,
      colors.section_bg,
    },
  },
}
gls.short_line_left[2] = {
  FileName = {
    provider = get_current_file_name,
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.section_bg },
    separator = " ",
    separator_highlight = { colors.section_bg, colors.bg },
  },
}

gls.short_line_right[1] = {
  BufferNumber = {
    -- provider = "BufferNumber",
    -- Custom provider fixes (overrides): /lua/galaxyline/provider_buffer.lua#L36
    -- https://git.io/Ju7Xa - not sure why they return the index not bufnr?
    provider = function()
      return vim.api.nvim_win_get_buf(0)
    end,
    icon = "﬘ ",
    highlight = { colors.dodgerblue, colors.bg },
  },
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
