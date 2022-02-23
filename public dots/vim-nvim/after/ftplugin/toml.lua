require("crates").setup()
local cmp = require "cmp"
cmp.setup.buffer { sources = { { name = "crates" }, name = "buffer" } }

-- crates mappings
-- upgrade crate on line
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  ",uc",
  [[<cmd>lua require('crates').upgrade_crate()<cr>
]],
  { noremap = true, silent = true }
)
