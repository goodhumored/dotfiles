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
local languagesPlugins = require("goodhumored.languages")

-- [[ Configure and install plugins ]]
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	{ import = "goodhumored.appearance.code" },
	{ import = "goodhumored.appearance.theme" },
	{ import = "goodhumored.snacks.snacks-nvim" },
	{ import = "goodhumored.appearance.ui" },
	{ import = "goodhumored.appearance.tint-unfocused" },
	{ import = "goodhumored.comfort-features" },
	{ import = "goodhumored.core" },
	{ import = "goodhumored.core.dap" },
	{ import = "goodhumored.editing" },
	{ import = "goodhumored.editing.snippets" },
	{ import = "goodhumored.integrations" },
	{ import = "goodhumored.sessions" },
	languagesPlugins.plugins,
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
