vim.api.nvim_create_augroup("jdtls_lsp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "jdtls_lsp",
	pattern = "java",
	callback = function()
		require("config.jdtls").setup_jdtls()
	end,
})

-- vim.api.nvim_create_augroup("autosave", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "VimLeavePre" }, {
-- 	group = "autosave",
-- 	callback = function()
-- 		local function is_any_buffer_modified()
-- 			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
-- 				if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "modified") then
-- 					return true
-- 				end
-- 			end
-- 			return false
-- 		end
--
-- 		if is_any_buffer_modified() then
-- 			vim.schedule(function()
-- 				vim.cmd("silent! wa")
-- 			end)
-- 		end
-- 	end,
-- })
