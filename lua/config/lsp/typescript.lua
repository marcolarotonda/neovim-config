local M = {}

function M.setup(lspconfig, capabilities)
	lspconfig.ts_ls.setup({
		capabilities = capabilities,
	})
	-- lspconfig.biome.setup({
	-- 	capabilities = capabilities,
	-- })
end

return M
