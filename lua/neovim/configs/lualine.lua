local lualine = require "lualine"

local colors = {
	bg = "",
	fg = "#bbc2cf",
	dark = "#232323",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	normal_mode_color = "#70bcff",
	green = "#d4ffb2",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	pink = "#ffa8f5",
	red = "#ec5f67",
	filename_bg = "#2a2f4f",
	-- lsp_fg = "#a9a1e1",
	lsp_fg = "#73717f",
	git_branch = "#878787",
	git_diff = "#757575",
	-- separator_mode_color = '#405958'
	-- separator_mode_color = '#5d5f6b',
	separator_mode_color = "#323866",
	progress_color = "#70bcff",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand "%:t") ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand "%:p:h"
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		-- icons_enabled = true,
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

-- -- Component for angled separator
local empty = require("lualine.component"):extend()
function empty:draw(default_highlight)
	self.status = "\u{e0ba}" -- Character for the slanted separator
	self.applied_separator = ""
	self:apply_highlights(default_highlight)
	self:apply_section_separators()
	return self.status
end

local mode_color = {
	n = colors.normal_mode_color,
	i = colors.green,
	v = colors.pink,
	[""] = colors.pink,
	V = colors.pink,
	c = colors.yellow,
	no = colors.red,
	s = colors.orange,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.violet,
	Rv = colors.violet,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	["r?"] = colors.cyan,
	["!"] = colors.red,
	t = colors.red,
}

ins_left {
	"mode",
	color = function()
		-- auto change color according to neovims mode
		return { bg = mode_color[vim.fn.mode()], fg = colors.dark, gui = "bold" }
	end,
	fmt = function(str)
		local mode_icons = {
			["n"] = " ", -- Normal mode icon
			["i"] = " ", -- Insert mode icon
			["v"] = " ", -- Visual mode icon
			["V"] = " ", -- Visual Line mode icon
			[""] = " ", -- Visual Block mode icon
			["c"] = " ", -- Command mode icon
			["s"] = " ", -- Select mode icon
			["S"] = " ", -- Select Line mode icon
			[""] = " ", -- Select Block mode icon
			["R"] = " ", -- Replace mode icon
			["Rv"] = " ", -- Virtual Replace mode icon
			["t"] = " ", -- Terminal mode icon
		}
		return mode_icons[vim.fn.mode()] .. str
	end,
	separator = { right = "\u{e0bc}" },
	separator_color = { bg = colors.red, fg = colors.red },
	padding = { left = 1, right = 1 },
}

ins_left {
	empty, -- Добавляем empty как отдельный компонент
	color = { fg = colors.separator_mode_color, bg = colors.separator_mode_color }, -- Цвет углового разделителя
	padding = { left = 0, right = 0 },
}

ins_left {
	"filename",
	cond = conditions.buffer_not_empty,
	-- icon = '', -- Использование стандартной иконки папки
	path = 0,
	color = { fg = colors.fg, bg = colors.filename_bg },
	padding = { left = 1, right = 1 },
	separator = { left = "\u{e0ba}", right = "" },
	separator_color = { bg = colors.red, fg = colors.red },
	symbols = {
		modified = "[+]", -- Text to show when the file is modified.
		readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
		unnamed = "[No Name]", -- Text to show for unnamed buffers.
		newfile = "[New]", -- Text to show for newly created file before first write
	},
	fmt = function(str)
		local icon = require("nvim-web-devicons").get_icon(vim.fn.expand "%:t", vim.fn.expand "%:e", { default = true })
		return icon .. " " .. str
	end,
}

ins_left {
	"branch",
	icon = "",
	color = { fg = colors.fg, gui = "bold" },
}

ins_left {
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.git_diff },
		modified = { fg = colors.git_diff },
		removed = { fg = colors.git_diff },
	},
	colored = true,
	cond = conditions.hide_in_width,
}

ins_right {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = "󰅙 ", warn = " ", info = "󰋼 ", hint = "󰛩 " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
}

ins_right {
	-- Lsp server name .
	function()
		local msg = "No Active Lsp "
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP ☞ ",
	-- color = {
	-- 	fg = colors.lsp_fg,
	-- 	-- gui = "bold"
	-- },
	color = function()
		-- auto change color according to neovims mode
		return { fg = mode_color[vim.fn.mode()] }
	end,
}

ins_right {
	-- "location",
	function()
		return "Ln " .. vim.fn.line "." .. "/"
	end,
	padding = { left = 1, right = 0 },
	-- icon = "", -- иконка для строки
}

ins_right {
	-- "location",
	function()
		return "%L "
	end,
	padding = { left = 0, right = 0 },
	color = { fg = colors.git_diff, gui = "bold" }, -- Цвет иконки и фона
	-- icon = "", -- иконка для строки
}

ins_right {
	-- "location",
	function()
		return "Col " .. vim.fn.col "."
	end,
	padding = { left = 0, right = 0 },
	-- icon = "", -- иконка для строки
}

ins_right {
	-- 'progress',
	"%p%%",
	-- color = { fg = mode_color[vim.fn.mode()], gui = "bold" },
	color = function()
		-- auto change color according to neovims mode
		return {
			fg = mode_color[vim.fn.mode()],
			-- gui = "bold",
		}
	end,
	padding = { left = 2, right = 1 },
	-- icon = "",
}

lualine.setup(config)
