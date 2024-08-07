return {
	{
		"mxsdev/nvim-dap-vscode-js",
		opts = {
			debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		},
	},
	{
		"microsoft/vscode-js-debug",
		build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv -f dist out",
	},
}
