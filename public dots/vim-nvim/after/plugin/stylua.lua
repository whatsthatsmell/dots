-- Used to run stylua automatically if in a Lua file & writing
-- & the file "stylua.toml" exists in the base root of the repo.
-- `stylua 0.17.0` → https://github.com/JohnnyMorganz/StyLua

if vim.fn.executable "stylua" == 0 then
  require "notify"("Stylua is not installed", "warn", { title = "Stylua" })
  return
end

-- format Lua files pre-write
vim.api.nvim_create_augroup("StyluaAuto", {})
vim.api.nvim_create_autocmd(
  "BufWritePre",
  { command = "lua require('joel.stylua').format()", group = "StyluaAuto", pattern = "*.lua" }
)
