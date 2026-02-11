return {
	"mfussenegger/nvim-dap-python",
	config = function()
		require("dap-python").setup("python3")

		local dap = require("dap")
		table.insert(dap.configurations.python, {
			type = "python",
			request = "launch",
			name = "Launch as module",
			module = "main",
			console = "integratedTerminal",
			cwd = vim.fn.getcwd(),
		})

		vim.keymap.set("n", "<leader>dt", function()
			require("dap-python").test_method()
		end, { desc = "[D]ebug [t]est method" })
		require("dap-python").setup("python3")
		vim.keymap.set("n", "<leader>dT", function()
			require("dap-python").test_class()
		end, { desc = "[D]ebug [T]est class" })
	end,
}
