return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true, -- Включить иконки
				theme = "gruvbox-material",
				component_separators = { left = " ", right = " " },
				section_separators = { left = " ", right = " " },
				disabled_filetypes = { -- Отключить lualine для определённых типов файлов
					statusline = {},
					winbar = {},
				},
				-- always_divide_middle = true,
				globalstatus = true, -- Один статусбар для всех окон
			},
			sections = {
				lualine_a = { "mode" }, -- Режим (Normal, Insert, etc.)
				lualine_b = { "branch", "diagnostics" }, -- Git и диагностика
				lualine_c = { "filename" }, -- Имя файла
				lualine_x = { "fileformat", "filetype" }, -- Кодировка, формат, тип файла
				lualine_y = { "progress" }, -- Прогресс в файле
				lualine_z = { "location" }, -- Положение курсора
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
