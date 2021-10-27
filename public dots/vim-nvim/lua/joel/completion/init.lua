-- Setup nvim-cmp
local cmp = require "cmp"

-- try cmp-cmdline completion for /search
-- @TODOUA: try ':' later
-- cmdline_buffer src for space handling in cmd search '/'...
-- -- it's a temp solution from: https://github.com/hrsh7th/nvim-cmp/issues/417
-- -- I have mixed feelings about cmdline_buffer in its current form. Watching above for fleshed out src.
cmp.register_source("cmdline_buffer", require("cmp_buffer").new())
cmp.setup.cmdline("/", {
  sources = cmp.config.sources {
    -- { name = "cmdline_buffer", opts = { keyword_pattern = [=[[^[:blank:]].*]=] } },
    { name = "buffer" },
  },
})

local lspkind = require "lspkind"

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    -- Right is for ghost_text to behave like terminal
    ["<Right>"] = cmp.mapping.confirm { select = true },
    -- Don't insert if I explicitly exit
    -- Don't insert if I explicitly exit
    -- Start completion manually with C-Space to have it truly clean-up
    ["<C-e>"] = cmp.mapping.abort(),
    -- Insert instead of Select so you don't go away at `stopinsert` after `CursorHoldI`
    -- @TODOUA: I want to be able to `Select` without `stopinsert` killing it (& keep `stopinsert`)
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, { "i", "c" }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, { "i", "c" }),
  },
  experimental = {
    ghost_text = true,
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = {
    -- 'crates' is lazy loaded
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "vsnip" },
    { name = "path" },
    {
      name = "buffer",
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "spell" },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "ﲳ",
        nvim_lua = "",
        treesitter = "",
        path = "ﱮ",
        buffer = "﬘",
        zsh = "",
        vsnip = "",
        spell = "暈",
      })[entry.source.name]

      return vim_item
    end,
  },
}
