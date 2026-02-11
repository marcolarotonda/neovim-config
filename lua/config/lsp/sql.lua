local M = {}

function M.setup(lspconfig, capabilities)
	local db_secrets = require("secrets.db")
	local db_utils = require("utils.db")

	lspconfig.sqlls.setup({
		capabilities = capabilities,
		settings = {
			sqlLanguageServer = {
				connections = db_utils.get_config_list(db_secrets).for_lsp,
			},
		},
	})
end

return M
