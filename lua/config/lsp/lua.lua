local M = {}

function M.setup(lspconfig, capabilities)
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
	})
end

return M
