-- Function to evaluate the variable or expression under the cursor or selected in visual mode
local function dap_evaluate_expression()
	local dap = require("dap")
	if not dap.session() then
		print("No active debug session")
		return
	end

	-- Determine if we're in visual mode and get the expression
	local expression
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" or mode == "<C-v>" then
		-- Visual mode: grab the selected text
		local start_pos = vim.fn.getpos("v")
		local end_pos = vim.fn.getpos(".")
		local start_line, start_col = start_pos[2], start_pos[3]
		local end_line, end_col = end_pos[2], end_pos[3]

		-- Handle multi-line selections or single-line selections
		if start_line == end_line then
			local line = vim.fn.getline(start_line)
			expression = string.sub(line, start_col, end_col)
		else
			local lines = vim.fn.getline(start_line, end_line)
			lines[1] = string.sub(lines[1], start_col)
			lines[#lines] = string.sub(lines[#lines], 1, end_col)
			expression = table.concat(lines, "\n")
		end

		-- Exit visual mode after grabbing the selection
		vim.api.nvim_command("normal! <Esc>")
	else
		-- Normal mode: grab the word under the cursor
		expression = vim.fn.expand("<cword>")
	end

	-- Ask the debugger to evaluate the expression
	dap.session():request("evaluate", {
		expression = expression,
		context = "repl",
	}, function(err, response)
		if err then
			print("Error evaluating expression: " .. err.message)
			return
		end
		if response and response.result then
			-- Show the result in the command line
			vim.api.nvim_echo({ { expression .. " = " .. response.result, "Normal" } }, true, {})
		else
			print("No result for expression: " .. expression)
		end
	end)
end

-- Bind it to a key, e.g., <leader>de
vim.keymap.set("n", "<leader>de", dap_evaluate_expression, { desc = "Evaluate expression under cursor" })

return {
	"mfussenegger/nvim-dap",
	recommended = true,
	desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mxsdev/nvim-dap-vscode-js",
		"theHamsta/nvim-dap-virtual-text",
	},

	config = function()
		local dap = require("dap")
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}", -- Replace with your chosen port number
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = { "/usr/bin/dapDebugServer.js", "${port}" },
			},
		}
		dap.adapters.node2 = {
			type = "executable",
			command = "node",
			args = { "/usr/lib/vscode-node-debug2/out/src/nodeDebug.js" },
		}

		if not dap.adapters["node"] then
			dap.adapters["node"] = function(cb, config)
				if config.type == "node" then
					config.type = "pwa-node"
				end
				local nativeAdapter = dap.adapters["pwa-node"]
				if type(nativeAdapter) == "function" then
					nativeAdapter(cb, config)
				else
					cb(nativeAdapter)
				end
			end
		end
		for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch NestJS App",
					program = "${workspaceFolder}/src/main.ts",
					runtimeExecutable = "node",
					runtimeArgs = { "-r", "ts-node/register" },
					envFile = "${workspaceFolder}/.env",
					trace = true,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "node",
				},
				-- Debug nodejs processes (make sure to add --inspect when you run the process)
				{
					name = "Attach",
					type = "pwa-node",
					request = "attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
				},
				{
					-- For this to work you need to make sure the node process is started with the `--inspect` flag.
					name = "Attach to process",
					type = "node2",
					request = "attach",
					processId = require("dap.utils").pick_process,

					-- From https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/dap.lua
					-- To test how it behaves
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					sourceMapPathOverrides = {
						["./*"] = "${workspaceFolder}/src/*",
					},
				},
			}
		end

		dap.configurations.go = {
			{
				type = "go",
				name = "Debug",
				request = "launch",
				program = "${file}",
			},
		}

		dap.adapters.cortex = {
			type = "executable",
			command = "arm-none-eabi-gdb",
			args = { "-x", "${workspaceFolder}/debug.gdb" },
		}

		dap.configurations.c = {
			{
				name = "Debug STM32",
				type = "cortex",
				request = "launch",
				program = "${workspaceFolder}/build/main.elf",
				cwd = "${workspaceFolder}",
				stopOnEntry = true,
			},
		}

		-- setup dap config by VsCode launch.json file
		local vscode = require("dap.ext.vscode")
		local json = require("plenary.json")
		vscode.json_decode = function(str)
			return vim.json.decode(json.json_strip_comments(str))
		end

		-- Extends dap.configurations with entries read from .vscode/launch.json
		if vim.fn.filereadable(".vscode/launch.json") then
			vscode.load_launchjs()
		end
	end,

	keys = {
		{ "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<leader>de",
			dap_evaluate_expression,
			desc = "Evaluate expression under cursor or selection",
			mode = { "n", "v" },
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>da",
			function()
				require("dap").continue({ before = get_args })
			end,
			desc = "Run with Args",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to Line (No Execute)",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Contine debug",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
		},
	},
}
