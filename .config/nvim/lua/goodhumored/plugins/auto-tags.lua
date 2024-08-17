--          ╭─────────────────────────────────────────────────────────╮
--          │                     nvim-ts-autotag                     │
--          │   Use treesitter to autoclose and autorename html tag   │
--          │        https://github.com/windwp/nvim-ts-autotag        │
--          ╰─────────────────────────────────────────────────────────╯
return {
	"windwp/nvim-ts-autotag",
	opts = {
		opts = {
			-- Defaults
			enable_close = true, -- Auto close tags
			enable_rename = true, -- Auto rename pairs of tags
			enable_close_on_slash = false, -- Auto close on trailing </
		},
		-- Also override individual filetype configs, these take priority.
		-- Empty by default, useful if one of the "opts" global settings
		-- doesn't work well in a specific filetype
		per_filetype = {
			["html"] = {
				enable_close = true,
			},
		},
	},
}