return {
	"uga-rosa/ccc.nvim",
	config = function()
		vim.opt.termguicolors = true

		local ccc = require("ccc")

		ccc.setup({
			-- Your preferred settings
			-- Example: enable highlighter
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		})
	end,
}
