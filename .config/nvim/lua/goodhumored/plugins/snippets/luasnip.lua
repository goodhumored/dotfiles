return {
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
}
