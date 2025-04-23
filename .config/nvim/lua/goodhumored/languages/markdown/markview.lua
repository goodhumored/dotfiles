--          ╭─────────────────────────────────────────────────────────╮
--          │                        markview                         │
--          │                   markdown beautifier                   │
--          ╰─────────────────────────────────────────────────────────╯
return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended
	-- ft = "markdown" -- If you decide to lazy-load anyway

	dependencies = {
		-- You will not need this if you installed the
		-- parsers manually
		-- Or if the parsers are in your $RUNTIMEPATH
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		-- Настройка markview.nvim
		require("markview").setup({
			modes = { "n", "i", "c" },
			hybrid_modes = { "i" },
			checkboxes = {
				enable = false, -- Отключить чекбоксы, чтобы избежать конфликта с obsidian.nvim
			},
			headings = {
				enable = true,
				level_1 = {
					style = "icon",
					icon = "📌 ",
					hl = "MarkviewHeading1",
					padding_left = " ",
					padding_right = " ",
				},
				level_2 = {
					style = "icon",
					icon = "📋 ",
					hl = "MarkviewHeading2",
					padding_left = "  ",
					padding_right = " ",
				},
				level_3 = {
					style = "icon",
					icon = "📝 ",
					hl = "MarkviewHeading3",
					padding_left = "   ",
					padding_right = " ",
				},
				level_4 = {
					style = "icon",
					icon = "🔖 ",
					hl = "MarkviewHeading4",
					padding_left = "    ",
					padding_right = " ",
				},
			},
			list_items = {
				enable = false,
				marker_minus = { rendered = "•" },
				marker_star = { rendered = "★" },
				marker_plus = { rendered = "➕" },
			},
			links = {
				enable = false,
				conceal = false,
				hl = "Underlined",
			},
			conceal = {
				enabled = true,
			},
		})
	end,
}
