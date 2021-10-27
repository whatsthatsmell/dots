local cmp = require "cmp"
-- cmp.register_source("zsh", require "joel.completion.zsh")
cmp.setup.buffer {
  sources = {
    { name = "vsnip" },
    { name = "zsh" },
    { name = "path" },
    { name = "treesitter" },
    { name = "spell" },
    {
      name = "buffer",
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  },
}
vim.b.vsnip_snippet_dir = vim.fn.expand "~/.config/nvim/snippets/zsh/"
