-- Always on bleeding edge Neovim from https://git.io/NeovimHEAD --
-- NVIM v0.8.0-dev+296-g307c5c63e

-- Plugins --
require "joel.plugins"

-- Config/Setup --
require "joel.config"

-- Telescope 🔭
require "joel.telescope"

-- mappings (telescope-related maps loaded via telescope mod)
require "joel.mappings"

-- settings(options)
require "joel.settings"

-- globals like P() & DN()
require "joel.globals"
