return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/notes/personal",
			},
			{
				name = "work",
				path = "~/notes/work/",
			},
			{
				name = "study",
				path = "~/notes/study",
			},
		},
		-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
		-- way then set 'mappings = {}'.
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<leader>njt"] = {
				action = function()
					return vim.cmd("ObsidianToday")
				end,
				opts = { noremap = true, buffer = true, desc = "Open [t]oday's daily note" },
			},
			["<leader>njT"] = {
				action = function()
					return vim.cmd("ObsidianTomorrow")
				end,
				opts = { noremap = true, buffer = true, desc = "Open [t]omorrow's daily note" },
			},
			["<leader>njy"] = {
				action = function()
					return vim.cmd("ObsidianYesterday")
				end,
				opts = { noremap = true, buffer = true, desc = "Open [y]esterday's daily note" },
			},
			["<leader>nj"] = {
				action = function()
					return vim.cmd("ObsidianDailies")
				end,
				opts = { noremap = true, buffer = true, desc = "Obsidian dailies" },
			},
			["<leader>so"] = {
				action = function()
					return vim.cmd("ObsidianSearch")
				end,
				opts = { noremap = true, buffer = true, desc = "[S]earch [O]bsidian" },
			},
			["<leader>ow"] = {
				action = function()
					return vim.cmd("ObsidianWorkspace")
				end,
				opts = { noremap = true, buffer = true, desc = "[O]bsidian [W]orkspace" },
			},
			["<leader>on"] = {
				action = function()
					return vim.cmd("ObsidianNew")
				end,
				opts = { noremap = true, buffer = true, desc = "[O]bsidian [N]ew" },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "daily",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d-[%a№%W]",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = " %-d %B %Y [%a№%W], %A",
			-- Optional, default tags to add to each new daily note created.
			default_tags = { "daily-notes" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = nil,
		},
		ui = {
			enable = true, -- set to false to disable all additional syntax features
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			max_file_length = 5000, -- disable UI features for files with more than this many lines
			-- Define how various check-boxes are displayed
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["."] = { char = "󰦖", hl_group = "ObsidianInProgress" },
				["x"] = { char = "󰸞", hl_group = "ObsidianDone" },
				["="] = { char = "", hl_group = "ObsidianPause" },
				[">"] = { char = "󱞩", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "", hl_group = "ObsidianTilde" },
				["!"] = { char = "󱈸", hl_group = "ObsidianImportant" },
				-- Replace the above with this if you don't have a patched font:
				-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
				-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

				-- You can also add more custom ones...
			},
			-- Use bullet marks for non-checkbox lists.
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			-- Replace the above with this if you don't have a patched font:
			-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			block_ids = { hl_group = "ObsidianBlockID" },
			hl_groups = {
				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
				ObsidianTodo = { bold = true, fg = "#89ddff" },
				ObsidianInProgress = { bold = true, fg = "#a8e0ae" },
				ObsidianDone = { bold = true, fg = "#84c470" },
				ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
				ObsidianTilde = { bold = true, fg = "#bbbcc7" },
				ObsidianImportant = { bold = true, fg = "#d73128" },
				ObsidianPause = { bold = true, fg = "#bcd1a7" },
				ObsidianBullet = { bold = true, fg = "#89ddff" },
				ObsidianRefText = { underline = true, fg = "#c792ea" },
				ObsidianExtLinkIcon = { fg = "#c792ea" },
				ObsidianTag = { italic = true, fg = "#89ddff" },
				ObsidianBlockID = { italic = true, fg = "#89ddff" },
				ObsidianHighlightText = { bg = "#75662e" },
			},
		},

		-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
		-- URL it will be ignored but you can customize this behavior here.
		---@param url string
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			-- vim.fn.jobstart({ "xdg-open", url }) -- Mac OS
			-- vim.fn.jobstart({"xdg-open", url})  -- linux
			-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
			vim.ui.open(url) -- need Neovim 0.10.0+
		end,
		-- Specify how to handle attachments.
		attachments = {
			-- The default folder to place images in via `:ObsidianPasteImg`.
			-- If this is a relative path it will be interpreted as relative to the vault root.
			-- You can always override this per image by passing a full path to the command instead of just a filename.
			img_folder = "assets/imgs", -- This is the default

			-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
			---@return string
			img_name_func = function()
				-- Prefix image names with timestamp.
				return string.format("%s-", os.time())
			end,

			-- A function that determines the text to insert in the note when pasting an image.
			-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
			-- This is the default implementation.
			---@param client obsidian.Client
			---@param path obsidian.Path the absolute path to the image file
			---@return string
			img_text_func = function(client, path)
				path = client:vault_relative_path(path) or path
				return string.format("![%s](%s)", path.name, path)
			end,
		},

		-- see below for full list of options 👇
	},
}
