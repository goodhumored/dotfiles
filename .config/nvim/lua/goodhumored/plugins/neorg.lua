return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
							uni = "~/Uni",
							job = "~/job",
							side = "~/side-hustle",
						},
						default_workspace = "notes",
					},
				},
			},
		})

		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,

	keys = {
		{
			"<leader>n",
			":Neorg<CR>",
			desc = "[N]eorg",
		},
		{
			"<leader>nw",
			":Neorg workspace<CR>",
			desc = "[N]eorg [W]orkspaces",
		},
		{
			"<leader>nj",
			":Neorg journal<CR>",
			desc = "[N]eorg [J]ournal",
		},
		{
			"<leader>ni",
			":Neorg index<CR>",
			desc = "[N]eorg [I]ndex",
		},
	},
}
