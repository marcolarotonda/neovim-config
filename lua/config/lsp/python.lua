local M = {}

function M.setup(lspconfig, capabilities)
	lspconfig.basedpyright.setup({
		capabilities = capabilities,
		settings = {
			basedpyright = {
				disableOrganizeImports = true,
				disableTaggedHints = false,
				analysis = {
					typeCheckingMode = "standard",
					useLibraryCodeForTypes = true, -- Analyze library code for type information
					autoImportCompletions = true,
					autoSearchPaths = true,
					diagnosticSeverityOverrides = {
						reportIgnoreCommentWithoutRule = true,
					},
				},
			},
			python = {
				analysis = {
					ignore = { "*" }, -- ignora l'analisi di pywright
				},
			},
		},
	})

	lspconfig.ruff.setup({
		capabilities = capabilities,
		init_options = {
			settins = {
				logLevel = "debug",
				trace = "messages",
			},
		},
	})
end

return M
