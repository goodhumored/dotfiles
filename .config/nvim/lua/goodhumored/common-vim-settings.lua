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
vim.opt.number = true
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
-- vim.opt.signcolumn = "number"

-- Removes ~ after file end
vim.opt.fillchars:append({ eob = " " })

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

vim.o.termguicolors = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
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

--          ╭─────────────────────────────────────────────────────────╮
--          │                         Langmap                         │
--          ╰─────────────────────────────────────────────────────────╯

local function escape(str)
	-- Эти символы должны быть экранированы, если встречаются в langmap
	local escape_chars = [[;,."|\]]
	return vim.fn.escape(str, escape_chars)
end

-- Наборы символов, введенных с зажатым шифтом
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
-- Наборы символов, введенных как есть
-- Здесь я не добавляю ',.' и 'бю', чтобы впоследствии не было рекурсивного вызова комманды
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm,.]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмитьбю]]
vim.opt.langmap = vim.fn.join({
	--  ; - разделитель, который не нужно экранировать
	--  |
	escape(ru_shift)
		.. ";"
		.. escape(en_shift),
	escape(ru) .. ";" .. escape(en),
}, ",")

--          ╭─────────────────────────────────────────────────────────╮
--          │  enable word wrap and linebreak for norg and markdown   │
--          │                          files                          │
--          ╰─────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "norg", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})

--          ╭─────────────────────────────────────────────────────────╮
--          │               autoclose untouched buffers               │
--          ╰─────────────────────────────────────────────────────────╯

-- Отладочная функция для логирования
-- local function debug_log(msg)
-- 	print("[BufferAutoClose] " .. msg)
-- end
--
-- -- Инициализация признака для новых буферов
-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
-- 	callback = function()
-- 		local buf = vim.api.nvim_get_current_buf()
-- 		local buf_name = vim.api.nvim_buf_get_name(buf)
-- 		local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
-- 		-- Пропускаем специальные буферы и nvim-tree
-- 		if buftype == "" and not buf_name:match("^NvimTree_") then
-- 			vim.api.nvim_buf_set_var(buf, "ever_modified", false)
-- 			debug_log("Initialized ever_modified=false for buffer " .. buf .. " (" .. buf_name .. ")")
-- 		else
-- 			debug_log("Skipped initialization for buffer " .. buf .. " (" .. buf_name .. "), buftype: " .. buftype)
-- 		end
-- 	end,
-- })
--
-- -- Отслеживаем изменения в буфере
-- vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
-- 	callback = function()
-- 		local buf = vim.api.nvim_get_current_buf()
-- 		local buf_name = vim.api.nvim_buf_get_name(buf)
-- 		local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
-- 		local modified = vim.api.nvim_buf_get_option(buf, "modified")
-- 		-- Пропускаем специальные буферы и nvim-tree
-- 		if buftype == "" and not buf_name:match("^NvimTree_") and modified then
-- 			vim.api.nvim_buf_set_var(buf, "ever_modified", true)
-- 			debug_log("Set ever_modified=true for buffer " .. buf .. " (" .. buf_name .. ")")
-- 		else
-- 			debug_log(
-- 				"Skipped modification check for buffer "
-- 					.. buf
-- 					.. " ("
-- 					.. buf_name
-- 					.. "), buftype: "
-- 					.. buftype
-- 					.. ", modified: "
-- 					.. tostring(modified)
-- 			)
-- 		end
-- 	end,
-- })
--
-- -- Закрываем немодифицированные буферы, которые никогда не изменялись
-- vim.api.nvim_create_autocmd({ "BufLeave", "BufHidden" }, {
-- 	callback = function()
-- 		local buf = vim.api.nvim_get_current_buf()
-- 		local buf_name = vim.api.nvim_buf_get_name(buf)
-- 		local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
-- 		-- Пропускаем специальные буферы и nvim-tree
-- 		if buftype ~= "" or buf_name:match("^NvimTree_") then
-- 			debug_log("Skipped buffer " .. buf .. " (" .. buf_name .. "), buftype: " .. buftype)
-- 			return
-- 		end
-- 		-- Проверяем существование ever_modified
-- 		local ever_modified = false
-- 		local success, result = pcall(vim.api.nvim_buf_get_var, buf, "ever_modified")
-- 		if success then
-- 			ever_modified = result
-- 		else
-- 			debug_log("No ever_modified for buffer " .. buf .. " (" .. buf_name .. "), assuming false")
-- 		end
-- 		-- Проверяем условия для закрытия
-- 		local modified = vim.api.nvim_buf_get_option(buf, "modified")
-- 		-- local is_hidden = vim.fn.bufwinnr(buf) == -1 || true
-- 		local is_hidden = true
-- 		local is_loaded = vim.api.nvim_buf_is_loaded(buf)
-- 		debug_log(
-- 			"Checking buffer "
-- 				.. buf
-- 				.. " ("
-- 				.. buf_name
-- 				.. "): modified="
-- 				.. tostring(modified)
-- 				.. ", hidden="
-- 				.. tostring(is_hidden)
-- 				.. ", loaded="
-- 				.. tostring(is_loaded)
-- 				.. ", ever_modified="
-- 				.. tostring(ever_modified)
-- 		)
-- 		if not modified and is_hidden and is_loaded and not ever_modified then
-- 			local delete_success, delete_error = pcall(vim.api.nvim_buf_delete, buf, { force = true })
-- 			if delete_success then
-- 				debug_log("Deleted buffer " .. buf .. " (" .. buf_name .. ")")
-- 			else
-- 				debug_log("Failed to delete buffer " .. buf .. " (" .. buf_name .. "): " .. tostring(delete_error))
-- 			end
-- 		else
-- 			debug_log(
-- 				"Buffer "
-- 					.. buf
-- 					.. " ("
-- 					.. buf_name
-- 					.. ") not deleted: "
-- 					.. (modified and "modified" or "")
-- 					.. " "
-- 					.. (not is_hidden and "not hidden" or "")
-- 					.. " "
-- 					.. (not is_loaded and "not loaded" or "")
-- 					.. " "
-- 					.. (ever_modified and "ever_modified" or "")
-- 			)
-- 		end
-- 	end,
-- })
