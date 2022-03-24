-- Always on bleeding edge Neovim from https://git.io/NeovimHEAD --
-- NVIM v0.7.0-dev+1307-ga72f338d7

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
