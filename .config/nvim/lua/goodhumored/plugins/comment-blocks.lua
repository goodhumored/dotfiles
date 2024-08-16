return {
	"LudoPinelli/comment-box.nvim",
	config = function()
		vim.keymap.set({ "n", "v" }, "gcb", "<cmd>CBccbox<CR>", { desc = "[C]omment [B]lock" })
		vim.keymap.set({ "n", "v" }, "gcl", "<cmd>CBccline<CR>", { desc = "[C]omment [L]ine" })
		vim.keymap.set({ "n", "v" }, "gc-", "<cmd>CBline<CR>", { desc = "[C]omment Simple [L]ine" })
	end,
}
