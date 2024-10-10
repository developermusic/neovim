local telescope = require "telescope"

telescope.setup {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		-- file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		-- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		-- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		-- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		-- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		-- mappings = {
		--   n = { ["q"] = require("telescope.actions").close },
		-- },
	},

	-- extensions_list = { "themes", "terms" },
	extensions = {},
}

telescope.load_extension "fzf"

local builtin = require "telescope.builtin"
local map = vim.keymap.set

-- FILES
map(
	"n",
	"<leader>ff",
	builtin.find_files,
	{ desc = "Lists files in your current working directory, respects .gitignore" }
)
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "Lists all files in your current working directory, hidden etc. " }
)
map("n", "<leader>fo", builtin.oldfiles, { desc = "Lists previously open files" })

-- TEXT
map("n", "<leader>fg", builtin.live_grep, { desc = "Search for a string in your current working directory" })
map(
	"n",
	"<leader>fz",
	builtin.current_buffer_fuzzy_find,
	{ desc = "Live fuzzy search inside of the currently open buffer" }
)
map(
	"n",
	"<leader>fc",
	builtin.grep_string,
	{ desc = "Searches for the string under your cursor or selection in your current working directory" }
)

-- BUFFERS
map("n", "<leader>fb", builtin.buffers, { desc = "Show opened buffers" })

-- VIM MARKS
map("n", "<leader>fm", builtin.marks, { desc = "Lists vim marks and their value" })

-- TODO NOTES
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- HELP TAGS
map(
	"n",
	"<leader>fh",
	builtin.help_tags,
	{ desc = "Lists available help tags and opens a new window with the relevant help info" }
)

-- LSP
map("n", "<leader>fr", builtin.lsp_references, { desc = "Lists LSP references for word under the cursor" })
map("n", "<leader>fs", builtin.lsp_workspace_symbols, { desc = "Lists LSP document symbols in the current workspace" })
map(
	"n",
	"<leader>fd",
	builtin.diagnostics,
	{ desc = "Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer." }
)
map("n", "<leader>fld", builtin.lsp_definitions, {
	desc = "Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope",
})
map("n", "<leader>fli", builtin.lsp_implementations, {
	desc = "Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope",
})
map("n", "<leader>flt", builtin.lsp_type_definitions, {
	desc = "Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope",
})

-- GIT
map("n", "<leader>gc", builtin.git_commits, {
	desc = "Lists git commits with diff preview, checkout action",
})
map("n", "<leader>gb", builtin.git_branches, {
	desc = "Lists all branches with log preview,",
})
map("n", "<leader>gi", builtin.git_status, {
	desc = "Lists current changes per file with diff preview and add action",
})
map("n", "<leader>gs", builtin.git_stash, {
	desc = "Lists stash items in current repository with ability",
})
map("n", "<leader>gf", "<cmd>Flog<cr>", { desc = "Git flog" })
