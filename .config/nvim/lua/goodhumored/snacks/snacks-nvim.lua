return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = { enabled = true },
		debug = { enabled = true },
		image = {
			enabled = true,
			formats = {
				"png",
				"jpg",
				"jpeg",
				"gif",
				"bmp",
				"webp",
				"tiff",
				"heic",
				"avif",
				"mp4",
				"mov",
				"avi",
				"mkv",
				"webm",
				"pdf",
			},
			force = false, -- try displaying the image, even if the terminal does not support it
			doc = {
				-- enable image viewer for documents
				-- a treesitter parser must be available for the enabled languages.
				enabled = true,
				-- render the image inline in the buffer
				-- if your env doesn't support unicode placeholders, this will be disabled
				-- takes precedence over `opts.float` on supported terminals
				inline = true,
				-- render the image in a floating window
				-- only used if `opts.inline` is disabled
				float = true,
				max_width = 80,
				max_height = 40,
				-- Set to `true`, to conceal the image text when rendering inline.
				conceal = false, -- (experimental)
			},
			img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
			-- window options applied to windows displaying image buffers
			-- an image buffer is a buffer with `filetype=image`
			wo = {
				wrap = false,
				number = false,
				relativenumber = false,
				cursorcolumn = false,
				signcolumn = "no",
				foldcolumn = "0",
				list = false,
				spell = false,
				statuscolumn = "",
			},
			cache = vim.fn.stdpath("cache") .. "/snacks/image",
			debug = {
				request = false,
				convert = false,
				placement = false,
			},
			env = {},
			---@class snacks.image.convert.Config
			convert = {
				notify = true, -- show a notification on error
				---@type snacks.image.args
				mermaid = function()
					local theme = vim.o.background == "light" and "neutral" or "dark"
					return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
				end,
				---@type table<string,snacks.image.args>
				magick = {
					default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
					vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
					math = { "-density", 192, "{src}[0]", "-trim" },
					pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
				},
			},
			math = {
				enabled = true, -- enable math expression rendering
				-- in the templates below, `${header}` comes from any section in your document,
				-- between a start/end header comment. Comment syntax is language-specific.
				-- * start comment: `// snacks: header start`
				-- * end comment:   `// snacks: header end`
				typst = {
					tpl = [[
	#set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
	#show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
	#set text(size: 12pt, fill: rgb("${color}"))
	${header}
	${content}]],
				},
				latex = {
					font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
					-- for latex documents, the doc packages are included automatically,
					-- but you can add more packages here. Useful for markdown documents.
					packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
					tpl = [[
	\documentclass[preview,border=2pt,varwidth,12pt]{standalone}
	\usepackage{${packages}}
	\begin{document}
	${header}
	{ \${font_size} \selectfont
	  \color[HTML]{${color}}
	${content}}
	\end{document}]],
				},
			},
		},
		explorer = { enabled = true },
		git = { enabled = true },
		indent = { enabled = true },
		-- input = { enabled = true },
		-- picker = { enabled = true },
		-- notifier = { enabled = true },
		-- quickfile = { enabled = true },
		-- scope = { enabled = true },
		scratch = { enabled = true }, -- https://github.com/folke/snacks.nvim/blob/main/docs/scratch.md
		win = { enabled = true },
		terminal = { enabled = true }, -- https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md
		animate = { enabled = true },
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
			-- faster animation when repeating scroll after delay
			animate_repeat = {
				delay = 100, -- delay in ms before using the repeat animation
				duration = { step = 1, total = 25 },
				easing = "linear",
			},
			-- what buffers to animate
			filter = function(buf)
				return vim.g.snacks_scroll ~= false
					and vim.b[buf].snacks_scroll ~= false
					and vim.bo[buf].buftype ~= "terminal"
			end,
		},
		-- statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>gb",
			function()
				require("snacks").git.blame_line()
			end,
			desc = "[G]it [B]lame",
		},
		{
			"<leader>.",
			function()
				require("snacks").scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				require("snacks").scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
