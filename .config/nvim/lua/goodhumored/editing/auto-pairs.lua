return {
	"windwp/nvim-autopairs",
	-- config = function()
	-- 	require("nvim-autopairs").setup({
	-- 		check_ts = true, -- Опционально, если используешь treesitter
	-- 	})
	--
	-- 	-- Переопределяем автокомманду BufEnter
	-- 	vim.api.nvim_create_autocmd("BufEnter", {
	-- 		group = vim.api.nvim_create_augroup("NvimAutopairsCustom", { clear = true }),
	-- 		callback = function()
	-- 			if vim.bo.filetype ~= "NvimTree" then
	-- 				require("nvim-autopairs").on_enter()
	-- 			end
	-- 		end,
	-- 	})
	-- end,
}
