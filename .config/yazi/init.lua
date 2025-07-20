-- You can configure your bookmarks by lua language
local bookmarks = {}

function path(...)
	local args = { ... }
	local path_sep = package.config:sub(1, 1)
	-- Trim leading slashes from the first element
	args[1] = args[1]:gsub("^/*", "")
	-- Trim trailing slashes from the last element
	args[#args] = args[#args]:gsub("/*$", "")
	-- Join the arguments with the path separator
	return path_sep .. table.concat(args, path_sep)
end

local home_path = os.getenv("HOME")
table.insert(bookmarks, {
	tag = "Downloads",
	path = path(home_path, "Downloads", ""),
	key = "d",
})
table.insert(bookmarks, {
	tag = "Notes",
	path = path(home_path, "notes", ""),
	key = "n",
})
table.insert(bookmarks, {
	tag = "Job",
	path = path(home_path, "Job", ""),
	key = "j",
})
table.insert(bookmarks, {
	tag = "Uni",
	path = path(home_path, "Uni", ""),
	key = "u",
})
table.insert(bookmarks, {
	tag = "side-hustle",
	path = path(home_path, "side-hustle", ""),
	key = "s",
})
table.insert(bookmarks, {
	tag = "trash",
	path = "/run/user/1000/kio-fuse-LJbUkF/trash/",
	key = "t",
})

-- require("yamb"):setup({
-- 	-- Optional, the path ending with path seperator represents folder.
-- 	bookmarks = bookmarks,
-- 	-- Optional, recieve notification everytime you jump.
-- 	jump_notify = true,
-- 	-- Optional, the cli of fzf.
-- 	cli = "fzf",
-- 	-- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
-- 	keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
-- 	-- Optional, the path of bookmarks
-- 	path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark")
-- 		or (os.getenv("HOME") .. "/.config/yazi/bookmark"),
-- })
