return {
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				active = true,
				on_config_done = nil,
				manual_mode = false,
				detection_methods = {
					"pattern",
				},
				patterns = {
					".git",
					"pubspec.yaml",
					"Cargo.toml",
					".nvimproj",
				},
				show_hidden = true,
				scope_chdir = "global",
				silent_chdir = true,
			})
			require("telescope").load_extension("projects")
			vim.keymap.set({ "n" }, "<leader>pf", function()
				require("telescope").extensions.projects.projects({})
			end, { desc = "[P]rojects [F]ind" })
		end,
	},
	-- {
	-- 	"coffebar/neovim-project",
	-- 	opts = {
	-- 		projects = { -- define project roots
	-- 			"~/Projects/*",
	-- 			"~/.config/*",
	-- 			"~/side-hustle/*",
	-- 			"~/Job/dipal/repos/*",
	-- 			"~/Uni/*/*/*",
	-- 		},
	-- 	},
	-- 	init = function()
	-- 		-- enable saving the state of plugins in the session
	-- 		vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
	-- 	end,
	-- 	config = function()
	-- 		vim.keymap.set(
	-- 			{ "n" },
	-- 			"<leader>pf",
	-- 			"<cmd>Telescope neovim-project discover<CR>",
	-- 			{ desc = "[P]rojects [F]ind" }
	-- 		)
	-- 		vim.keymap.set(
	-- 			{ "n" },
	-- 			"<leader>pr",
	-- 			"<cmd>Telescope neovim-project history<CR>",
	-- 			{ desc = "[P]rojects [R]ecent" }
	-- 		)
	-- 		vim.keymap.set(
	-- 			{ "n" },
	-- 			"<leader>pl",
	-- 			"<cmd>NeovimProjectLoadRecent<CR>",
	-- 			{ desc = "[P]rojects load [L]ast" }
	-- 		)
	-- 	end,
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
	-- 		{ "Shatur/neovim-session-manager" },
	-- 	},
	-- 	lazy = false,
	-- 	priority = 100,
	-- },
}
