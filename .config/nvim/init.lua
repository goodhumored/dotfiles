--[[

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html
  I have left several `:help X` comments throughout the init.lua
If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.
--]]

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set the number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs

-- word wrap options
vim.opt.wrap = false -- disable wrap

-- true if have nerd font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- splitting
vim.keymap.set("n", "<leader>-", "<cmd>sp<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>|", "<cmd>vsp<CR>", { desc = "Vertical split" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { desc = "Switch to next tab", noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":tabprev<CR>", { desc = "Switch to previous tab", noremap = true, silent = true })
vim.keymap.set("n", "<C-PageUp>", ":tabnext<CR>", { desc = "Switch to next tab", noremap = true, silent = true })
vim.keymap.set("n", "<C-PageDown>", ":tabprev<CR>", { desc = "Switch to previous tab", noremap = true, silent = true })
vim.keymap.set("n", "tl", ":tabnext<CR>", { desc = "[T]ab right", noremap = true, silent = true })
vim.keymap.set("n", "th", ":tabprev<CR>", { desc = "[T]ab left", noremap = true, silent = true })
vim.keymap.set("n", "tj", ":tabfirst<CR>", { desc = "[T]ab home", noremap = true, silent = true })
vim.keymap.set("n", "tk", ":tablast<CR>", { desc = "[T]ab end", noremap = true, silent = true })

-- Move selected line(s) up
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move selected line(s) down
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- vim.filetype.add({
-- 	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
--
-- })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.hl", "hypr*.conf" },
	callback = function(event)
		print(string.format("starting hyprls for %s", vim.inspect(event)))
		vim.lsp.start({
			name = "hyprlang",
			cmd = { "hyprls" },
			root_dir = vim.fn.getcwd(),
		})
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{
		"https://github.com/nvim-treesitter/nvim-treesitter-context.git",
		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		},
	},
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				-- { "<leader>e", group = "[E]xplorer" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			})
		end,
	},
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				tsserver = {
					commands = {
						OrganizeImports = {
							function()
								vim.lsp.buf.execute_command({
									command = "_typescript.organizeImports",
									arguments = { vim.api.nvim_buf_get_name(0) },
								})
							end,
							description = "Organize imports",
						},
					},
				},
				--

				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				eslint = {
					validate = "onSave",
					autoFixOnSave = true,
					autoFix = true,
				},
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"eslint_d",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- ol gur freire pbasvthengvba nobir. Hfrshy jura qvfnoyvat
						-- pregnva srngherf bs na YFC (sbe rknzcyr, gheavat bss sbeznggvat sbe gffreire)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {

			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				typescript = { "prettier" },
				javascript = { "prettier" },
			},
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- If you prefer more traditional completion keymaps,
					-- you can uncomment the following lines
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-k>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<M-space>",
					node_incremental = "<M-space>",
					node_decremental = "<M-backspace>",
					scope_incremental = "<c-s>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
			},
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			-- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
			local api = require("nvim-tree.api")
			vim.keymap.set("n", "<leader>e", api.tree.toggle, { desc = "[E]xplorer" })
			vim.keymap.set("n", "<leader>E", function()
				api.tree.find_file({ open = true, focus = true })
			end, { desc = "Focus file in [E]xplorer" })
		end,
	},
	{
		"https://github.com/christoomey/vim-tmux-navigator.git",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
		{
			"nvim-neotest/neotest",
			dependencies = {
				"marilari88/neotest-vitest",
				"nvim-neotest/nvim-nio",
			},
			keys = {
				{
					"<leader>tr",
					function()
						require("neotest").run.run()
					end,
					desc = "[T]ests [R]un",
				},
				{
					"<leader>tf",
					function()
						require("neotest").run.run(vim.fn.expand("%"))
					end,
					desc = "[T]ests run [F]ile",
				},
				{
					"<leader>tdr",
					function()
						require("neotest").run.run({ strategy = "dap" })
					end,
					desc = "[T]est [D]ebug [R]elated",
				},
				{
					"<leader>tdf",
					function()
						require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
					end,
					desc = "[T]ests [D]ebug [F]ile",
				},
				{
					"<leader>twr",
					function()
						require("neotest").run.run({ vitestCommand = "vitest --watch" })
					end,
					desc = "[T]est [W]atch [R]elated",
				},
				{
					"<leader>twf",
					function()
						require("neotest").run.run({ vim.fn.expand("%"), vitestCommand = "vitest --watch" })
					end,
					desc = "[T]ests [W]atch [F]ile",
				},
				{
					"<leader>ts",
					function()
						require("neotest").summary.toggle()
					end,
					desc = "[T]ests [S]ummary",
				},
				{
					"<leader>tx",
					function()
						require("neotest").run.stop()
					end,
					desc = "[T]est stop",
				},
				{
					"<leader>to",
					function()
						require("neotest").output.open()
					end,
					desc = "[T]est [O]utput",
				},
				{
					"<leader>tO",
					function()
						require("neotest").output_panel.toggle()
					end,
					desc = "[T]est [O]utput",
				},
			},
			config = function()
				local neotest = require("neotest")
				neotest.setup({
					adapters = {
						require("neotest-vitest")({
							-- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
							filter_dir = function(name, rel_path, root)
								return name ~= "node_modules" or name ~= "dist"
							end,
							-- is_test_file = function(file_path)
							-- 	return file_path:match(".*%.spec%.ts") ~= nil
							-- end,
						}),
					},
				})
			end,
		},
		-- firenvim (firefox neovim extension)
		{
			"glacambre/firenvim",
			build = ":call firenvim#install(0)",
			config = function()
				vim.g.firenvim_config = {
					globalSettings = { alt = "all" },
					localSettings = {
						[".*"] = {
							cmdline = "neovim",
							content = "text",
							priority = 0,
							selector = "textarea",
							takeover = "never",
						},
						-- ["https?:\\/\\/(www\\.)?google\\.com.*"] = { takeover = "never", priority = 1 },
					},
				}
			end,
		},
		{
			"uga-rosa/ccc.nvim",
			config = function()
				vim.opt.termguicolors = true

				local ccc = require("ccc")
				local mapping = ccc.mapping

				ccc.setup({
					-- Your preferred settings
					-- Example: enable highlighter
					highlighter = {
						auto_enable = true,
						lsp = true,
					},
				})
			end,
		},
		{
			"rmagatti/auto-session",
			lazy = false,
			dependencies = {
				"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
			},
			opts = {
				auto_session_enabled = true,
				auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
				auto_save_enabled = true,
				auto_restore_enabled = true,
				auto_session_allowed_dirs = nil,
				auto_session_create_enabled = true,
				auto_session_enable_last_session = false,
				auto_session_use_git_branch = false,
				auto_restore_lazy_delay_enabled = true,
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				log_level = "error",
			},
		},
		{
			"LudoPinelli/comment-box.nvim",
			config = function()
				vim.keymap.set({ "n", "v" }, "<leader>cb", "<cmd>CBccbox<CR>", { desc = "[C]omment [B]lock" })
				vim.keymap.set({ "n", "v" }, "<leader>cl", "<cmd>CBccline<CR>", { desc = "[C]omment [L]ine" })
				vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CBline<CR>", { desc = "[C]omment Simple [L]ine" })
			end,
		},
		{
			"utilyre/barbecue.nvim",
			name = "barbecue",
			version = "*",
			dependencies = {
				"SmiteshP/nvim-navic",
				"nvim-tree/nvim-web-devicons", -- optional dependency
			},
			opts = {
				-- configurations go here
			},
		},
		{
			"romgrk/barbar.nvim",
			dependencies = {
				"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
				"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
			},
			init = function()
				vim.g.barbar_auto_setup = false
				vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { desc = "Go tab left" })
				vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { desc = "Go tab right" })
				-- Re-order to previous/next
				vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { desc = "Move tab left" })
				vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { desc = "Move tab right" })
				-- Goto buffer in position...
				vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { desc = "Go to tab 1" })
				vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { desc = "Go to tab 2" })
				vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { desc = "Go to tab 3" })
				vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { desc = "Go to tab 4" })
				vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { desc = "Go to tab 5" })
				vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { desc = "Go to tab 6" })
				vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { desc = "Go to tab 7" })
				vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { desc = "Go to tab 8" })
				vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { desc = "Go to tab 9" })
				vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", { desc = "Go to tab 0" })
				-- Pin/unpin buffer
				vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", { desc = "Pin tab" })
				-- Close buffer
				vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { desc = "Close tab" })
				vim.keymap.set("n", "<A-/>", "<Cmd>BufferPick<CR>", { desc = "Pick tab" })
			end,
			opts = {
				sidebar_filetypes = {
					-- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
					NvimTree = true,
					-- Or, specify the text used for the offset:
					undotree = {
						text = "undotree",
						align = "center", -- *optionally* specify an alignment (either 'left', 'center', or 'right')
					},
					-- Or, specify the event which the sidebar executes when leaving:
					["neo-tree"] = { event = "BufWipeout" },
					-- Or, specify all three
					Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
				},
			},
			version = "^1.0.0", -- optional: only update when a new 1.x version is released
		},
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
		{ "rafamadriz/friendly-snippets" },
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
			config = function()
				-- load snippets from path/of/your/nvim/config/my-cool-snippets
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = { "~/.config/Code/User/snippets/typescript.code-snippets" },
				})
			end,
		},
		{
			"MysticalDevil/inlay-hints.nvim",
			event = "LspAttach",
			dependencies = { "neovim/nvim-lspconfig" },
			config = function()
				require("inlay-hints").setup()
				-- require("typescript-tools").setup({
				-- 	settings = {
				-- 		tsserver_file_preferences = {
				-- 			includeInlayParameterNameHints = "all",
				-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				-- 			includeInlayFunctionParameterTypeHints = true,
				-- 			includeInlayVariableTypeHints = true,
				-- 			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				-- 			includeInlayPropertyDeclarationTypeHints = true,
				-- 			includeInlayFunctionLikeReturnTypeHints = true,
				-- 			includeInlayEnumMemberValueHints = true,
				-- 		},
				-- 	},
				-- })
				require("lspconfig").tsserver.setup({
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				})
			end,
		},
		{
			"jiangmiao/auto-pairs",
		},
		{
			"rcarriga/nvim-dap-ui",
			event = "VeryLazy",
			dependencies = "mfussenegger/nvim-dap",
			config = function()
				local dap = require("dap")
				local dapui = require("dapui")
				require("dapui").setup()
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
			end,
		},
		-- vscode-js-debug adapter
		{
			"microsoft/vscode-js-debug",
			build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv -f dist out",
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			opts = {
				debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			},
		},
		{
			"mfussenegger/nvim-dap",
			recommended = true,
			desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

			dependencies = {
				"rcarriga/nvim-dap-ui",
				-- virtual text for the debugger
				"mxsdev/nvim-dap-vscode-js",
				{
					"theHamsta/nvim-dap-virtual-text",
					opts = {},
				},
			},

			keys = {
				{ "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
				{
					"<leader>dB",
					function()
						require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
					end,
					desc = "Breakpoint Condition",
				},
				{
					"<leader>db",
					function()
						require("dap").toggle_breakpoint()
					end,
					desc = "Toggle Breakpoint",
				},
				{
					"<leader>dc",
					function()
						require("dap").continue()
					end,
					desc = "Continue",
				},
				{
					"<leader>da",
					function()
						require("dap").continue({ before = get_args })
					end,
					desc = "Run with Args",
				},
				{
					"<leader>dC",
					function()
						require("dap").run_to_cursor()
					end,
					desc = "Run to Cursor",
				},
				{
					"<leader>dg",
					function()
						require("dap").goto_()
					end,
					desc = "Go to Line (No Execute)",
				},
				{
					"<leader>di",
					function()
						require("dap").step_into()
					end,
					desc = "Step Into",
				},
				{
					"<leader>dj",
					function()
						require("dap").down()
					end,
					desc = "Down",
				},
				{
					"<leader>dk",
					function()
						require("dap").up()
					end,
					desc = "Up",
				},
				{
					"<leader>dl",
					function()
						require("dap").run_last()
					end,
					desc = "Run Last",
				},
				{
					"<leader>do",
					function()
						require("dap").step_out()
					end,
					desc = "Step Out",
				},
				{
					"<leader>dO",
					function()
						require("dap").step_over()
					end,
					desc = "Step Over",
				},
				{
					"<leader>dp",
					function()
						require("dap").pause()
					end,
					desc = "Pause",
				},
				{
					"<leader>dr",
					function()
						require("dap").repl.toggle()
					end,
					desc = "Toggle REPL",
				},
				{
					"<leader>ds",
					function()
						require("dap").session()
					end,
					desc = "Session",
				},
				{
					"<leader>dt",
					function()
						require("dap").terminate()
					end,
					desc = "Terminate",
				},
				{
					"<leader>dw",
					function()
						require("dap.ui.widgets").hover()
					end,
					desc = "Widgets",
				},
				{
					"<F5>",
					function()
						require("dap").continue()
					end,
					desc = "Contine debug",
				},
				{
					"<F10>",
					function()
						require("dap").step_over()
					end,
					desc = "Step over",
				},
				{
					"<F11>",
					function()
						require("dap").step_into()
					end,
					desc = "Step into",
				},
				{
					"<F12>",
					function()
						require("dap").step_out()
					end,
					desc = "Step out",
				},
			},

			config = function()
				local dap = require("dap")
				dap.adapters["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = "${port}", -- Replace with your chosen port number
					executable = {
						command = "node",
						-- 💀 Make sure to update this path to point to your installation
						args = { "/usr/bin/dapDebugServer.js", "${port}" },
					},
				}
				dap.adapters.node2 = {
					type = "executable",
					command = "node",
					args = { "/usr/lib/vscode-node-debug2/out/src/nodeDebug.js" },
				}

				if not dap.adapters["node"] then
					dap.adapters["node"] = function(cb, config)
						if config.type == "node" then
							config.type = "pwa-node"
						end
						local nativeAdapter = dap.adapters["pwa-node"]
						if type(nativeAdapter) == "function" then
							nativeAdapter(cb, config)
						else
							cb(nativeAdapter)
						end
					end
				end
				for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
					dap.configurations[lang] = {
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = "${workspaceFolder}",
							runtimeExecutable = "node",
						},
						-- Debug nodejs processes (make sure to add --inspect when you run the process)
						{
							name = "Attach",
							type = "pwa-node",
							request = "attach",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
							sourceMaps = true,
						},
						{
							-- For this to work you need to make sure the node process is started with the `--inspect` flag.
							name = "Attach to process",
							type = "node2",
							request = "attach",
							processId = require("dap.utils").pick_process,

							-- From https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/dap.lua
							-- To test how it behaves
							rootPath = "${workspaceFolder}",
							cwd = "${workspaceFolder}",
							console = "integratedTerminal",
							internalConsoleOptions = "neverOpen",
							sourceMapPathOverrides = {
								["./*"] = "${workspaceFolder}/src/*",
							},
						},
					}
				end
				-- setup dap config by VsCode launch.json file
				local vscode = require("dap.ext.vscode")
				local json = require("plenary.json")
				vscode.json_decode = function(str)
					return vim.json.decode(json.json_strip_comments(str))
				end

				-- Extends dap.configurations with entries read from .vscode/launch.json
				if vim.fn.filereadable(".vscode/launch.json") then
					vscode.load_launchjs()
				end
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
	},
	-- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	-- { import = 'custom.plugins' },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
