local gitsigns = require "gitsigns"

gitsigns.setup {
	signs = {
		delete = { text = "󰍵" },
		changedelete = { text = "󱕖" },
	},
	auto_attach = true,
}

on_attach = function(bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = desc }
	end

	local map = vim.keymap.set

	map("n", "<leader>rh", gitsigns.reset_hunk, opts "Reset Hunk")
	map("n", "<leader>ph", gitsigns.preview_hunk, opts "Preview Hunk")
	map("n", "<leader>gb", gitsigns.blame_line, opts "Blame Line")
end
