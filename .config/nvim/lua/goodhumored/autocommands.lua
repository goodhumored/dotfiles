vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.ts",
	callback = function()
		vim.cmd("OrganizeImports")
	end,
})
