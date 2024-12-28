--          ╭─────────────────────────────────────────────────────────╮
--          │               ekickx/clipboard-image.nvim               │
--          │               paste images into markdown                │
--          ╰─────────────────────────────────────────────────────────╯
return {
	"postfen/clipboard-image.nvim",
	config = function()
		require("clipboard-image").setup({
			default = {
				img_name = function()
					vim.fn.inputsave()
					local name = vim.fn.input("Name: ")
					vim.fn.inputrestore()
					if name == nil or name == "" then
						name = os.date("%d-%m-%y-%H:%M:%S")
					end
					return name
				end,
				img_handler = function(img)
					vim.cmd("normal! f[") -- go to [
					vim.cmd("normal! a" .. img.name) -- append text with image name
				end,

				img_dir = { "%:p:h", "img" },
			},
		})
		vim.keymap.set("n", "<leader>pi", "<cmd>PasteImg<CR>", { desc = "[P]aste [I]mage" })
	end,
}
