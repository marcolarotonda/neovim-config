return {
	"stevearc/conform.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim", -- opzionale, fornisce builtins extra
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
                html = {"prettierd", "prettier"}
			},
			linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			},
			lsp_fallback = true, -- usa LSP per linguaggi non configurati
		})

		vim.keymap.set("n", "<leader>cf", function()
			local ft = vim.bo.filetype

			-- lista dei filetype gestiti da conform
			local conform_filetypes = {
				lua = true,
				javascript = true,
				typescript = true,
				javascriptreact = true,
				typescriptreact = true,
                html = true
			}

			if conform_filetypes[ft] then
				require("conform").format({ async = true })
			else
				vim.lsp.buf.format({ async = true })
			end
		end, { desc = "[C]ode [F]ormat" })
	end,
}
