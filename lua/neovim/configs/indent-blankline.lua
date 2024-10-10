local highlight = {
	"IndentLevel1",
	"IndentLevel2",
	"IndentLevel3",
	"IndentLevel4",
	-- "IndentLevel5",
	-- "IndentLevel6",
}

local hooks = require "ibl.hooks"

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "IndentLevel1", { fg = "#780108" })
	vim.api.nvim_set_hl(0, "IndentLevel2", { fg = "#754c00" })
	vim.api.nvim_set_hl(0, "IndentLevel3", { fg = "#0042bd" })
	-- vim.api.nvim_set_hl(0, "IndentLevel4", { fg = "#732865" })
	vim.api.nvim_set_hl(0, "IndentLevel4", { fg = "#296101" })
	-- vim.api.nvim_set_hl(0, "IndentLevel6", { fg = "#016370" })
end)

hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

require("ibl").setup {
	-- Отвечает за вертикальную полосу scope (постоянная)
	indent = {
		highlight = highlight,
		char = "│",
	},
	-- Отвечает за цветной отсуп (пробел или таб)
	whitespace = {
		-- highlight = { "CursorColumn", "Whitespace" },
		remove_blankline_trail = false,
	},
	-- Отвечает за отображение scope например функции или тега при попадании в тело
	scope = {
		enabled = true,
		char = "│",
		-- highlight = "",
	},
}
