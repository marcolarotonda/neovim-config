local db_utils = require("lua.utils.db")
local db_secrets = require("lua.secrets.db")

return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.dbs = {
			db_utils.format_config(db_secrets.dnd5e_test).dadbod_config,
			db_utils.format_config(db_secrets.dnd5e_prod).dadbod_config,
		}
		vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
	end,
}
