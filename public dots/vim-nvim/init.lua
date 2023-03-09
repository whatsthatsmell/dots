-- Always on bleeding edge Neovim from https://git.io/NeovimHEAD
-- NVIM v0.9.0-dev-1179+gce0fddf5a

-- https://github.com/lewis6991/impatient.nvim
-- :LuaCacheClear
require "impatient"

-- Plugins --
require "joel.plugins"

-- Config/Setup --
require "joel.config"

-- Telescope 🔭
require "joel.telescope"

-- Mappings (telescope-related maps loaded via telescope mod)
require "joel.mappings"

-- Settings(options)
require "joel.settings"

-- Globals like P() & DN()
require "joel.globals"
