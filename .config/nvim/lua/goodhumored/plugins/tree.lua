return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({})
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<leader>e", api.tree.toggle, { desc = "[E]xplorer" })
		vim.keymap.set("n", "<leader>E", function()
			api.tree.find_file({ open = true, focus = true })
		end, { desc = "Focus file in [E]xplorer" })
	end,
}
