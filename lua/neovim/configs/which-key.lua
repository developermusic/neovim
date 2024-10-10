local map = vim.keymap.set
-- WHICHKEY
map("n", "<leader>wk", "<cmd>whichkey <cr>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

local wk = require "which-key"
wk.add {
	{ "<leader>f", group = "Find" }, -- group
	{ "<leader>fl", desc = "Find LSP definitions, implementations, type_definitions", mode = "n" },

	{ "<leader>g", group = "Git" }, -- group

	{ "<leader>t", group = "Terminal" },

	{ "<leader>b", group = "Buffers" },

	{ "<leader>l", group = "LSP" },

	{ "<leader>s", group = "Split window" },

	{ "<leader>w", group = "Window" },
	{ "<leader>wn", group = "Numbers" },

	{ "<leader>t", group = "Terminal" },

	{ "<leader>d", group = "Debug" },

	{ "<leader>n", group = "Tests" },
}
