return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*",
	dependencies = {
		"nvim-neorg/lua-utils.nvim",
		"pysan3/pathlib.nvim",
	},
	config = function()
		local neorg = require("neorg")
		neorg.setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				-- ["core.integrations.image"] = {},
				-- ["core.latex.renderer"] = {},
				["core.export"] = {
					config = { -- Note that this table is optional and doesn't need to be provided
						-- Configuration here
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
							uni = "~/Uni",
							dipal = "~/Job/dipal/notes",
							side = "~/side-hustle/notes",
						},
						default_workspace = "notes",
						open_last_workspace = true,
					},
				},
				["core.qol.toc"] = {
					config = {
						close_split_on_jump = true,
					},
				},
			},
		})
		neorg.modules.get_module("core.dirman").set_closest_workspace_match()

		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,

	keys = {
		{
			"<leader>nw",
			":Neorg workspace ",
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
		{
			"<leader>nT",
			":Neorg toc qflist<CR>",
			desc = "[N]eorg [T]able of contents",
		},
		{
			"<leader>nr",
			":Neorg return<CR>",
			desc = "[N]eorg [R]eturn",
		},
		{
			"<leader>tl",
			":Neorg render-latex<CR>",
			desc = "[N]eorg [L]atex",
		},
	},
}
