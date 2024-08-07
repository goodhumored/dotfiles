return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
	},
	opts = {
		auto_session_enabled = true,
		auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
		auto_save_enabled = true,
		auto_restore_enabled = true,
		auto_session_allowed_dirs = nil,
		auto_session_create_enabled = true,
		auto_session_enable_last_session = false,
		auto_session_use_git_branch = false,
		auto_restore_lazy_delay_enabled = true,
		auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		log_level = "error",
	},
}
