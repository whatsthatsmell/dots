-- Used to run stylua automatically if in a Lua file & writing
-- & the file "stylua.toml" exists in the base root of the repo.
--
-- `stylua v0.11.2` → https://github.com/JohnnyMorganz/StyLua
-- Otherwise doesn't do anything.

if vim.fn.executable "stylua" == 0 then
  return
end

-- @TODOUA: figure out how to not lose last edit position or alt
vim.cmd [[
  augroup StyluaAuto
    autocmd BufWritePre *.lua :lua require("joel.stylua").format()
  augroup END
]]
