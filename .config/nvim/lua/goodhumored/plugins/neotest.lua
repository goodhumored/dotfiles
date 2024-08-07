return {
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
}
