require("crates").setup()
local cmp = require "cmp"
cmp.setup.buffer { sources = { { name = "crates" }, name = "buffer" } }

-- crates.nvim local mappings --
-- `upgrade` crate on line to NEWEST version
-- -- use `update` for newest Compatible version
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  ",uc",
  [[<cmd>lua require('crates').upgrade_crate()<cr>
]],
  { noremap = true, silent = true }
)

-- open repo of crate on current line
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  ",or",
  [[<cmd>lua require('crates').open_repository()<cr>
]],
  { noremap = true, silent = true }
)
