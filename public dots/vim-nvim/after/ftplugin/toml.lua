require("crates").setup()
local cmp = require "cmp"
cmp.setup.buffer { sources = { { name = "crates" }, name = "buffer" } }
