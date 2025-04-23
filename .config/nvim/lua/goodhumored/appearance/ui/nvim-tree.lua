return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local api = require("nvim-tree.api")

		local function edit_or_open()
			local node = api.tree.get_node_under_cursor()

			if node.nodes ~= nil then
				-- expand or collapse folder
				api.node.open.edit()
			else
				-- open file
				api.node.open.edit()
				-- Close the tree if file was opened
				api.tree.close()
			end
		end

		-- open as vsplit on current node
		local function vsplit_preview()
			local node = api.tree.get_node_under_cursor()

			if node.nodes ~= nil then
				-- expand or collapse folder
				api.node.open.edit()
			else
				-- open file as vsplit
				api.node.open.vertical()
			end

			-- Finally refocus on tree if it was lost
			api.tree.focus()
		end
		local function collapse_folder()
			local node = api.tree.get_node_under_cursor()
			api.node.navigate.parent(node)
			api.node.open.edit(node.parent)
		end
		require("nvim-tree").setup({
			on_attach = function(bufnr)
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end
				-- default mappings
				api.config.mappings.default_on_attach(bufnr)
				vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
				vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
				vim.keymap.set("n", "h", collapse_folder, opts("Close"))
				vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
			end,
		})
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<leader>e", api.tree.toggle, { desc = "[E]xplorer" })
		vim.keymap.set("n", "<leader>E", function()
			-- api.tree.open() -- Просто открываем дерево
			api.tree.find_file({ open = true, focus = true })
			-- api.tree.find_file({ focus = true })
		end, { desc = "Focus file in [E]xplorer" })
	end,
}
