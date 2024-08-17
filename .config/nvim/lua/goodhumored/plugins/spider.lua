--          ╭─────────────────────────────────────────────────────────╮
--          │                chrisgrieser/nvim-spider                 │
--          │                      ------------                       │
--          │    Replaces word jump mappings to improve horizontal    │
--          │                       navigation                        │
--          ╰─────────────────────────────────────────────────────────╯
return {
	"chrisgrieser/nvim-spider",
	keys = {
		{
			"<M-e>",
			"<cmd>lua require('spider').motion('e')<CR>",
			mode = { "n", "o", "x" },
		},
		{
			"<M-w>",
			"<cmd>lua require('spider').motion('w')<CR>",
			mode = { "n", "o", "x" },
		},
		{
			"<M-b>",
			"<cmd>lua require('spider').motion('b')<CR>",
			mode = { "n", "o", "x" },
		},
	},
}
