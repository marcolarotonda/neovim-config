return {
	{
		"williamboman/mason.nvim",
		config = function()
			-- setup mason with default properties
			require("mason").setup()
		end,
	},
	-- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- ensure that we have lua language server, java language server, and java test language server are installed
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jdtls",
					"basedpyright",
					"ruff",
					"sqlls",
					"dockerls",
					"biome",
					"ts_ls",
					"eslint@4.8.0",
					"angularls",
				},
			})
		end,
	},
	-- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			-- ensure the java debug adapter is installed
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test", "debugpy", "js-debug-adapter" },
			})
		end,
	},
	-- utility plugin for configuring the java language server for us
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- setup language servers
			require("config.lsp.lua").setup(lspconfig, capabilities)
			require("config.lsp.python").setup(lspconfig, capabilities)
			require("config.lsp.sql").setup(lspconfig, capabilities)
			require("config.lsp.docker").setup(lspconfig, capabilities)
			require("config.lsp.go").setup(lspconfig, capabilities)
			require("config.lsp.typescript").setup(lspconfig, capabilities)
			require("config.lsp.angular").setup(lspconfig, capabilities)

			-- LSP keymaps
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			vim.keymap.set(
				"n",
				"<leader>cr",
				require("telescope.builtin").lsp_references,
				{ desc = "[C]ode Goto [R]eferences" }
			)
			vim.keymap.set(
				"n",
				"<leader>ci",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[C]ode Goto [I]mplementations" }
			)
			vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
		end,
	},
}
