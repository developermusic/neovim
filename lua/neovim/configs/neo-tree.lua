require("neo-tree").setup {
	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
	enable_git_status = true,
	enable_diagnostics = true,
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		git_status = {
			symbols = {
				-- Change type
				added = "A", -- ✚ -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "M", --  -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "D", -- ✖ -- this can only be used in the git_status source
				renamed = "R", -- 󰁕 -- this can only be used in the git_status source
				-- Status type
				untracked = "UT", -- 
				ignored = "I", -- 
				unstaged = "US", -- 󰄱
				staged = "S", -- 
				conflict = "C", -- 
			},
		},
	},

	filesystem = {
		follow_current_file = { -- обновлять дерево на основе текущего файла
			enabled = true,
		},
		use_libuv_file_watcher = true, -- ускорение обновления файлов
		hijack_netrw_behavior = "open_default",

		-- filtered_items - возможно причина торможения плагина

		filtered_items = {
			visible = false, -- показать скрытые файлы
			hide_dotfiles = true,
			hide_gitignored = true,
		},
		find_by = "cwd", -- ограничить поиск текущей директорией
	},
}
