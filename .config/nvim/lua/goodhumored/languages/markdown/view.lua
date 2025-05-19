return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		bullet = {
			enabled = true,
			render_modes = false,
			icons = { "●", "○", "◆", "◇" },
			ordered_icons = function(ctx)
				local value = vim.trim(ctx.value)
				local index = tonumber(value:sub(1, #value - 1))
				return ("%d."):format(index > 1 and index or ctx.index)
			end,
			left_pad = 0,
			right_pad = 1,
			highlight = "RenderMarkdownBullet",
			scope_highlight = {},
		},
		heading = {
			sign = true,
			signs = { "", "＃", "＃", "＃", "＃", "＃", "＃" },
			position = { "inline" },
			width = { "full", "block" },
			-- left_margin = { 0.5, 0 },
			left_pad = { 0.5, 0 },
			right_pad = { 0.5, 1 },
			border = { true, false },
			-- icons = { "➊ ", "➋ ", "➌ ", "➍ ", "➎ ", "➏ ", "➐ " },
			icons = { --[["𝟙 "]]
				"",
				"𝟚 ",
				"𝟛 ",
				"𝟜 ",
				"𝟝 ",
				"𝟞 ",
				"𝟟 ",
			},
			backgrounds = {
				"BufferVisiblePin",
				"BufferVisiblePin",
				"BufferVisiblePin",
				"BufferVisiblePin",
				"BufferVisiblePin",
				"BufferVisiblePin",
			},
			foregrounds = {
				"RenderMarkdownH1",
				"RenderMarkdownH2",
				"RenderMarkdownH3",
				"RenderMarkdownH4",
				"RenderMarkdownH5",
				"RenderMarkdownH6",
			},
		},
	},
}
