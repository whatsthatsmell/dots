-- Always on bleeding edge Neovim from https://git.io/NeovimHEAD --

-- *** Neovim Config Luatized *** --
-- plugins
require "joel.plugins"

-- config/setup
require "joel.config"

-- Telescope 🔭
require "joel.telescope"

-- mappings (telescope-related maps loaded via telescope mod)
require "joel.mappings"

-- settings(options)
require "joel.settings"

-- globals like P() & DN()
require "joel.globals"
