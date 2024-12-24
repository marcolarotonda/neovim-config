local db_utils = require("utils.db")
local db_secrets = require("secrets.db")

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
        vim.g.dbs = db_utils.get_config_list(db_secrets).for_dadbod
		vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
	end,
}
