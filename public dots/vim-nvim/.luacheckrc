-- luacheck 0.26.0: https://github.com/lunarmodules/luacheck/releases/tag/v0.26.0
-- Rerun tests only if their modification time changed.
cache = true

std = luajit
codes = true

self = false

-- Glorious list of warnings: https://luacheck.readthedocs.io/en/stable/warnings.html
ignore = {
  "212", -- Unused argument, In the case of callback function, _arg_name is easier to understand than _, so this option is set to off.
  "122", -- Indirectly setting a readonly global
  "111", -- setting non-standard global variable...
}

globals = {
  "_",
  "TelescopeGlobalState",
  "TelescopeCachedUppers",
  "TelescopeCachedTails",
  "TelescopeCachedNgrams",
  "_TelescopeConfigurationValues",
  "_TelescopeConfigurationPickers",
  "__TelescopeKeymapStore",
  "P",
}

-- Global objects defined by the C code
read_globals = {
  "vim"
}
