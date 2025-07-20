local function getOpenRouterModel(model)
	return {
		__inherited_from = "openai",
		endpoint = "https://openrouter.ai/api/v1",
		api_key_name = "OPENROUTER_API_KEY",
		model = model,
	}
end

local function enabledCond(env)
	local fullEnv = "NVIM_USE_" .. env
	local value = vim.uv.os_getenv(fullEnv) == "true"
	if value == true then
		return true
	end
	return false
end

return {
	--          ╭─────────────────────────────────────────────────────────╮
	--          │                    copilot (Enabled)                    │
	--          ╰─────────────────────────────────────────────────────────╯
	{
		"github/copilot.vim",
		cond = enabledCond("COPILOT"), -- don't need this at all
		lazy = false,
		init = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_filetypes = {
				["markdown"] = false, -- Disables Copilot for .md files
			}
			vim.g.copilot_workspace_folders = {
				"~/Job/dipal/repos/Fox/Makaw/",
				"~/Job/dipal/repos/Fox/Fawn/",
				"~/Job/dipal/repos/Kaiser/Zoo/",
				"~/Job/dipal/repos/Kaiser/Iguana/",
				"~/Job/dipal/repos/Kaiser/Crow/",
				"~/Job/dipal/repos/Kaiser/Loki/",
				"~/Job/dipal/repos/Kaiser/Janus/",
				"~/Job/dipal/repos/dipal-common/",
				"~/Job/dipal/repos/Kaiser/Sphinx/",
				"~/Job/dipal/repos/Kaiser/Lyonid/",
				"~/Job/dipal/repos/Kaiser/Belfort/",
				"~/Job/dipal/repos/Kaiser/Pigeons/",
				"~/Job/dipal/repos/Kaiser/Pyrador/",
				"~/Job/dipal/repos/Kaiser/Goose/",
				"~/Job/dipal/repos/Kaiser/Odysseus/",
			}
		end,
		keys = {
			{
				"<A-l>",
				"copilot#Accept()",
				mode = "i",
				desc = "Accept Copilot suggestion",
				replace_keycodes = false,
				expr = true,
			},
			{ "<A-w>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Accept Copilot word" },
			{ "<A-j>", "<Plug>(copilot-next)", mode = "i", desc = "Next Copilot suggestion" },
			{
				"<A-k>",
				"<Plug>(copilot-previous)",
				mode = "i",
				desc = "Previous Copilot suggestion",
			},
			{ "<leader>cc", ":Copilot<CR>", desc = "Toggle Copilot" },
		},
	},
	--          ╭─────────────────────────────────────────────────────────╮
	--          │                    avante (Disabled)                    │
	--          ╰─────────────────────────────────────────────────────────╯
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = false,
		cond = function()
			return vim.uv.os_getenv("OPENROUTER_API_KEY") ~= nil
		end,
		version = false, -- Never set this value to "*"! Never!
		opts = {
			mode = "agentic",
			auto_suggestions_provider = "codestral",
			cursor_applying_provider = nil,
			provider = "codestral",
			vendors = {
				["claude"] = getOpenRouterModel("anthropic/claude-3.7-sonnet"),
				["codestral"] = getOpenRouterModel("mistralai/codestral-2501"),
				["qwen32"] = getOpenRouterModel("qwen/qwen-2.5-coder-32b-instruct"),
				["qwen7"] = getOpenRouterModel("qwen/qwen2.5-coder-7b-instruct"),
			},
			behaviour = {
				auto_suggestions = true, -- Experimental stage
				enable_cursor_planning_mode = true,
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
				minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
				enable_token_counting = true, -- Whether to enable token counting. Default to true.
			},
			mappings = {
				--- @class AvanteConflictMappings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				cancel = {
					normal = { "<C-c>", "<Esc>", "q" },
					insert = { "<C-c>" },
				},
			},
			hints = { enabled = true },
			suggestion = {
				debounce = 400,
				throttle = 400,
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			-- "echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			-- "ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			-- "zbirenbaum/copilot.lua", -- for providers='copilot'
			-- {
			--   -- support for image pasting
			--   "HakonHarnes/img-clip.nvim",
			--   event = "VeryLazy",
			--   opts = {
			--     -- recommended settings
			--     default = {
			--       embed_image_as_base64 = false,
			--       prompt_for_file_name = false,
			--       drag_and_drop = {
			--         insert_mode = true,
			--       },
			--       -- required for Windows users
			--       use_absolute_path = true,
			--     },
			--   },
			-- },
		},
	},
}
