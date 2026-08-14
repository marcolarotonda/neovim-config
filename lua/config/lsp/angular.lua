local M = {}

function M.setup(lspconfig, capabilities)
  local util = require("lspconfig.util")

  lspconfig.angularls.setup({
    capabilities = capabilities,
    cmd = {
      "ngserver",
      "--stdio",
      "--tsProbeLocations",
      vim.fn.getcwd(),
      "--ngProbeLocations",
      vim.fn.getcwd(),
    },
    filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
    root_dir = util.root_pattern("angular.json", "project.json"),
  })
end

return M
