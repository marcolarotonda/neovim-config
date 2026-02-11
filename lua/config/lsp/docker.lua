local M = {}

function M.setup(lspconfig, capabilities)
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		settings = {
			docker = {
				languageserver = {
					formatter = {
						ignoreMultilineInstructions = true,
					},
				},
			},
		},
	})
end

return M
