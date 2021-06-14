-- based on https://github.com/David-Kunz/vim - sort of working sometimes. 
local dap = require('dap')

local function debugJest(testName, filename)
  print("starting " .. testName .. " in " .. filename)
  dap.run({
      type = 'node2',
      request = 'launch',
      cwd = vim.fn.getcwd(),
      runtimeArgs = {'--inspect-brk', '/usr/local/bin/jest', '--no-coverage', '-t', testName, '--', filename},
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      console = 'integratedTerminal',
      port = 9229,
      })
end

local function attach()
  print("attaching")
  dap.run({
      type = 'node2',
      request = 'attach',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      })
end

local function debugGql()
  print("Debugging GQL Project")
  dap.run({
      type = 'node2',
      request = 'launch',
      cwd = vim.fn.getcwd(),
      runtimeArgs = {'--inspect-brk', 'node_modules/micro-dev/bin/micro-dev', '-s', '-p', '4000', 'dev.js'},
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      console = 'integratedTerminal',
      port = 9229,
      })
end
return {
  debugJest = debugJest,
  attach = attach,
  attachToRemote = attachToRemote,
  debugGql = debugGql
}

