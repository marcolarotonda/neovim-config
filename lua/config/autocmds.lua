vim.api.nvim_create_augroup("jdtls_lsp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "jdtls_lsp",
	pattern = "java",
	callback = function()
		require("config.jdtls").setup_jdtls()
	end,
})

-- don't fold query output with vim-dadbod-ui
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dbout' },
  callback = function()
    vim.opt.foldenable = false
  end,
})
