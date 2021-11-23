local cmp = require "cmp"
cmp.setup.buffer {
  sources = {
    { name = "vsnip" },
    { name = "zsh" },
    { name = "path" },
    { name = "treesitter" },
    { name = "spell" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  },
}
vim.b.vsnip_snippet_dir = vim.fn.expand "~/.config/nvim/snippets/zsh/"
