require("neo-tree").setup {
	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
	enable_git_status = true,
	enable_diagnostics = true,
}
default_component_configs = {
	container = {
		enable_character_fade = true,
	},
	git_status = {
		symbols = {
			-- Change type
			added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
			modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
			deleted = "✖", -- this can only be used in the git_status source
			renamed = "󰁕", -- this can only be used in the git_status source
			-- Status type
			untracked = "",
			ignored = "",
			unstaged = "󰄱",
			staged = "",
			conflict = "",
		},
	},
}
