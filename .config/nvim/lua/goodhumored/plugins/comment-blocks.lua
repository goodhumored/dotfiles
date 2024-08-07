return {
	"LudoPinelli/comment-box.nvim",
	config = function()
		vim.keymap.set({ "n", "v" }, "<leader>cb", "<cmd>CBccbox<CR>", { desc = "[C]omment [B]lock" })
		vim.keymap.set({ "n", "v" }, "<leader>cl", "<cmd>CBccline<CR>", { desc = "[C]omment [L]ine" })
		vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CBline<CR>", { desc = "[C]omment Simple [L]ine" })
	end,
}
