return {
	enabled = false,
	"olimorris/codecompanion.nvim",
	opts = {
		adapters = {
			openrouter_claude = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					env = {
						url = "https://openrouter.ai/api",
						api_key = vim.uv.os_getenv("OPENROUTER_API_KEY"),
						chat_url = "/v1/chat/completions",
					},
					schema = {
						model = {
							default = "anthropic/claude-3.7-sonnet",
							options = {
								"anthropic/claude-3.7-sonnet",
								"anthropic/claude-3.5-sonnet",
								"openai/gpt-4-turbo",
							},
						},
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "openrouter_claude",
			},
			inline = {
				adapter = "openrouter_claude",
			},
		},
	},
	keys = {
		{ "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "Code Companion Chat", mode = { "n", "v" } },
		{ "<leader>ci", "<cmd>CodeCompanionInline<cr>", desc = "Code Companion Inline", mode = { "n", "v" } },
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}
