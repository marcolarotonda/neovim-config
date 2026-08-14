return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- ui plugins to make debugging simplier
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		-- gain access to the dap plugin and its functions
		local dap = require("dap")
		-- gain access to the dap ui plugin and its functions
		local dapui = require("dapui")

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}
		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "My method to launch files",
				runtimeExecutable = "node",
				runtimeArgs = { "--import", "tsx", "${file}" },
				args = { "${file}" },
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				skipFiles = { "<node_internals>/**", "node_modules/**" },
				resolveSourceMapLocations = {
					"${workspaceFolder}/**",
					"!**/node_modules/**",
				},
			},
		}

		dap.configurations.typescript[#dap.configurations.typescript + 1] = {

			type = "pwa-node",
			request = "launch",
			name = "Debug Node Test Runner",
			runtimeExecutable = "node",
			runtimeArgs = { "--import", "tsx", "--test", "${file}" },
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		}

		dap.configurations.typescript[#dap.configurations.typescript + 1] = {
			type = "pwa-node",
			request = "launch",
			name = "Debug Vitest",
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/vitest/vitest.mjs",
				"--run",
				"${file}",
			},
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			sourceMaps = true,
			autoAttachChildProcesses = true,
		}

		-- Setup the dap ui with default configuration
		dapui.setup()

		-- setup an event listener for when the debugger is launched
		dap.listeners.before.launch.dapui_config = function()
			-- when the debugger is launched open up the debug ui
			dapui.open()
		end

		-- set a vim motion for <Space> + d + t to toggle a breakpoint at the line where the cursor is currently on
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug Toggle [B]reakpoint" })

		-- set a vim motion for <Space> + d + s to start the debugger and launch the debugging ui
		vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })

		-- set a vim motion to close the debugging ui
		vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "[D]ebug Step [O]ver" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug Step [I]nto" })
		vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "[D]ebug Step O[u]t" })
		vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { desc = "[D]ebug Set [B]reakpoint" })
		vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "[D]ebug [T]erminate" })
		vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = "[D]ebug [D]isconnect" })
		vim.keymap.set("n", "<leader>dC", dap.clear_breakpoints, { desc = "[D]ebug [C]lear breakpoints" })
	end,
}
