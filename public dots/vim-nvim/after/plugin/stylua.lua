-- Used to run stylua automatically if in a lua file & writing
-- & the file "stylua.toml" exists in the base root of the repo.
--
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
