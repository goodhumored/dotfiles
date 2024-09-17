--  ───────────────────── disable highlight on search ─────────────────────
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

--  ───────────────────────── Diagnostic keymaps ──────────────────────
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--          ╭─────────────────────────────────────────────────────────╮
--          │                        terminal                         │
--          ╰─────────────────────────────────────────────────────────╯
--  ────────── easy leave terminal (shortcut to ctrl+\, ctrl+n) ───────
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

--          ╭─────────────────────────────────────────────────────────╮
--          │                         Windows                         │
--          ╰─────────────────────────────────────────────────────────╯

--  ────────────────────────────── splitting ──────────────────────────────
vim.keymap.set("n", "<leader>-", "<C-w>s", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>|", "<C-w>v", { desc = "Vertical split" })

--  ──────────────────────────── resize panes ─────────────────────────
vim.keymap.set("n", "<left>", "<C-w><")
vim.keymap.set("n", "<right>", "<C-w>>")
vim.keymap.set("n", "<up>", "<C-w>+")
vim.keymap.set("n", "<down>", "<C-w>-")

vim.keymap.set("n", "<S-left>", "<C-w>H")
vim.keymap.set("n", "<S-right>", "<C-w>L")
vim.keymap.set("n", "<S-up>", "<C-w>K")
vim.keymap.set("n", "<S-down>", "<C-w>J")

--  ─────────────────────── CTRL+<hjkl> navigation ────────────────────
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

--  ─────────────────────────── tabs navigation ───────────────────────────
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { desc = "Switch to next tab", noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":tabprev<CR>", { desc = "Switch to previous tab", noremap = true, silent = true })
vim.keymap.set("n", "<C-PageUp>", ":tabnext<CR>", { desc = "Switch to next tab", noremap = true, silent = true })
vim.keymap.set("n", "<C-PageDown>", ":tabprev<CR>", { desc = "Switch to previous tab", noremap = true, silent = true })
vim.keymap.set("n", "tl", ":tabnext<CR>", { desc = "[T]ab right", noremap = true, silent = true })
vim.keymap.set("n", "th", ":tabprev<CR>", { desc = "[T]ab left", noremap = true, silent = true })
vim.keymap.set("n", "tj", ":tabfirst<CR>", { desc = "[T]ab home", noremap = true, silent = true })
vim.keymap.set("n", "tk", ":tablast<CR>", { desc = "[T]ab end", noremap = true, silent = true })

--          ╭─────────────────────────────────────────────────────────╮
--          │                      Moving lines                       │
--          ╰─────────────────────────────────────────────────────────╯
--  ────────────────────── Move selected line(s) up ───────────────────
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

--  ───────────────────── Move selected line(s) down ──────────────────
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
