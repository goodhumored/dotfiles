return {
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
		custom_buffer_name = function(bufnr)
			local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
			if filetype == "markdown" and vim.b[bufnr].obsidian_note then
				local note = vim.b[bufnr].obsidian_note
				return note.title
					or table.concat(note.aliases, ", ")
					or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t:r")
			end
			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
		end,
	},
	version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
