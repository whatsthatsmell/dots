-- Used to run stylua automatically if in a lua file & writing
-- & the file "stylua.toml" exists in the base root of the repo.
--
-- Otherwise doesn't do anything.

if vim.fn.executable "stylua" == 0 then
  return
end

-- @TODUA: move this to after/ft as key map. It interferes with GitSigns when done on write.
-- - This is my suspicion, I need to repro and verify and possibly fix to keep this current setup
-- -- note that the GitSigns interference is slightly inconsistent or I just don't understand it
-- -- - I may be blaming sylua unfairly. Need to test a Lua file outside the realm of Stylua.
-- -- - - But, it is only happening with Lua. So, Stylua is definitely the prime suspect.
vim.cmd [[
  augroup StyluaAuto
    autocmd BufWritePre *.lua :lua require("joel.stylua").format()
  augroup END
]]
