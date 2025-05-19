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

		-- Новая функция для dragon-drop на файле
		local function dragon_drop_file()
			local node = api.tree.get_node_under_cursor()
			local target_path = node.absolute_path

			vim.fn.system("dragon-drop " .. vim.fn.shellescape(target_path))
		end

		local function dragon_drop_directory()
			local node = api.tree.get_node_under_cursor()
			local target_path

			if node.nodes ~= nil then
				-- Если это директория, используем её
				target_path = node.absolute_path
			else
				-- Если это файл, используем родительскую директорию
				target_path = node.parent.absolute_path
			end

			vim.fn.system("dragon-drop -t " .. vim.fn.shellescape(target_path))
		end

		-- функция для копирования файла из буфера обмена
		local function copy_file_from_clipboard()
			local node = api.tree.get_node_under_cursor()
			local target_dir

			if node.nodes ~= nil then
				-- Если это директория, копируем в неё
				target_dir = node.absolute_path
			else
				-- Если это файл, копируем в родительскую директорию
				target_dir = node.parent.absolute_path
			end

			local source_path = vim.fn.getreg("+"):gsub("\n", "") -- Получаем путь из буфера обмена, убираем перенос строки

			-- Проверяем, существует ли файл
			if vim.fn.filereadable(source_path) == 0 then
				vim.notify("Invalid or non-existent file path in clipboard: " .. source_path, vim.log.levels.ERROR)
				return
			end

			-- Формируем команду cp
			local cmd = "cp " .. vim.fn.shellescape(source_path) .. " " .. vim.fn.shellescape(target_dir)
			local result = vim.fn.system(cmd)

			if vim.v.shell_error == 0 then
				vim.notify("File copied successfully to " .. target_dir, vim.log.levels.INFO)
				-- Обновляем дерево, чтобы отобразить новый файл
				api.tree.reload()
			else
				vim.notify("Failed to copy file: " .. result, vim.log.levels.ERROR)
			end
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
				vim.keymap.set("n", "<leader>d", dragon_drop_file, opts("Drag-n-drop file"))
				vim.keymap.set("n", "<leader>D", dragon_drop_directory, opts("Dragon Drop Directory"))
				vim.keymap.set("n", "<leader>p", copy_file_from_clipboard, opts("Paste file"))
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
