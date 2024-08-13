 return {
   'nvim-lualine/lualine.nvim',
   requires = { 'nvim-tree/nvim-web-devicons', opt = true },
   config = function()
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg						= '',
  fg						= '#bbc2cf',
	dark					= '#232323',
  yellow				= '#ECBE7B',
  cyan					= '#008080',
  darkblue			= '#081633',
	soft_green		= '#32948d',
  green					= '#d4ffb2',
  orange				= '#FF8800',
  violet				= '#a9a1e1',
  magenta				= '#c678dd',
  blue					= '#51afef',
  red						= '#ec5f67',
	filename_bg		= '#365150',
	lsp_fg				= '#a9a1e1',
	git_branch		= '#73717f',
	-- separator_mode_color = '#405958'
	separator_mode_color = '#415e5d',
	progress_color = '#908e9e'
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
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
local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = '\u{e0ba}' 	-- Character for the slanted separator
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

ins_left {
	 	'mode',
  color = function()
    -- auto change color according to neovims mode
		local mode_color = {
      n = colors.soft_green,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
			return { bg = mode_color[vim.fn.mode()] ,fg = colors.dark, gui = 'bold'}
    end,
		fmt = function(str)
      local mode_icons = {
				['n'] = ' ',      -- Normal mode icon
				['i'] = ' ',      -- Insert mode icon
				['v'] = ' ',      -- Visual mode icon
				['V'] = ' ',      -- Visual Line mode icon
				[''] = ' ',     -- Visual Block mode icon
				['c'] = ' ',      -- Command mode icon
				['s'] = ' ',      -- Select mode icon
				['S'] = ' ',      -- Select Line mode icon
				[''] = ' ',     -- Select Block mode icon
				['R'] = ' ',      -- Replace mode icon
				['Rv'] = ' ',     -- Virtual Replace mode icon
				['t'] = ' ',      -- Terminal mode icon
			}
			return mode_icons[vim.fn.mode()] .. str
		end,
    separator = { right ='\u{e0bc}'},
		separator_color = {bg = colors.red, fg = colors.red},
    padding = {left = 1, right = 0 },
}


ins_left {
  empty, -- Добавляем empty как отдельный компонент
  color = { fg = colors.separator_mode_color , bg = colors.separator_mode_color  }, -- Цвет углового разделителя
			 padding = {left = 0, right = 0}
}
-- 		 ins_left { function()
--     return ''
--   end,
--   color = { fg = colors.fg }, -- Sets highlighting of component
--   padding = { left = 0, right = 0 }, -- We don't need space before this
-- 			  -- separator = { right = '' },
--
-- }-- ins_left {
--   -- filesize component
--   'filesize',
--   cond = conditions.buffer_not_empty,
-- }

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
			-- icon = '', -- Использование стандартной иконки папки
	path = 0,
  color = { fg = colors.fg,bg = colors.filename_bg },
	padding = {left = 1, right = 1},
	separator = {   left = '\u{e0ba}' , right = '' },
			 	separator_color = {bg = colors.red, fg = colors.red},
		symbols = {
			modified = '[+]',      -- Text to show when the file is modified.
			readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
			unnamed = '[No Name]', -- Text to show for unnamed buffers.
			newfile = '[New]',     -- Text to show for newly created file before first write
		},
	fmt = function(str)
		local icon = require('nvim-web-devicons').get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })
		return icon .. ' ' .. str
	end
}

ins_left{
  'branch',
  icon = '',
  color = { fg = colors.git_branch, gui = 'bold' },
}

ins_left {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
	colored = false,
  cond = conditions.hide_in_width,
}

ins_right{
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰛩 ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
-- ins_left {
--   function()
--     return '%='
--   end,
-- }

ins_right {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp '
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
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
  icon = ' LSP:',
  color = { fg = colors.lsp_fg, gui = 'bold' },
}

-- Add components to right sections
-- ins_right {
--   'o:encoding', -- option component same as &encoding in viml
--   fmt = string.upper, -- I'm not sure why it's upper case either ;)
--   cond = conditions.hide_in_width,
--   color = { fg = colors.green, gui = 'bold' },
-- }

-- ins_right {
--   'fileformat',
--   fmt = string.upper,
--   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--   color = { fg = colors.green, gui = 'bold' },
-- }
-- ins_right {
--   function()
--     return '%='
--   end,
-- }

-- ins_left {
--   function()
--     return '▊'
--   end,
--   color = { fg = colors.blue }, -- Sets highlighting of component
--   padding = { left = 0, right = 1 }, -- We don't need space before this
-- }

ins_right {
 'location',
 }

ins_right { 
			-- 'progress', 
			'%p%% | %L',
			color = { fg = colors.progress_color, gui = 'bold' },
			icon = ' '
		}

-- Now don't forget to initialize lualine
lualine.setup(config)

end
}

-- return {
--   'nvim-lualine/lualine.nvim',
--   requires = { 'nvim-tree/nvim-web-devicons', opt = true },
--   config = function()
--     local colors = {
--       blue = '#80a0ff',
--       cyan = '#79dac8',
--       black = '#080808',
--       white = '#c6c6c6',
--       red = '#ff5189',
--       violet = '#32948d',
--       grey = '#303030'
--     }
--
--     local bubbles_theme = {
--       normal = {
--         a = { fg = colors.grey, bg = colors.violet },
--         b = { fg = colors.white, bg = colors.grey },
--         c = { fg = colors.black, bg = '' }
--       },
--
--       insert = { a = { fg = colors.black, bg = colors.blue } },
--       visual = { a = { fg = colors.black, bg = colors.cyan } },
--       replace = { a = { fg = colors.black, bg = colors.red } },
--
--       inactive = {
--         a = { fg = colors.white, bg = colors.black },
--         b = { fg = colors.white, bg = colors.black },
--         c = { fg = colors.black, bg = colors.black }
--       }
--     }
--
--     require('lualine').setup {
--       options = {
--         theme = bubbles_theme,
--         component_separators = '|',
--         -- section_separators = { left = '█', right = '█' },
--         globalstatus = true,
--       },
--       sections = {
--         lualine_a = {
--           {
--             'mode',
--             fmt = function(str)
--               local mode_icons = {
--                 ['n'] = ' ',      -- Normal mode icon
--                 ['i'] = ' ',      -- Insert mode icon
--                 ['v'] = ' ',      -- Visual mode icon
--                 ['V'] = ' ',      -- Visual Line mode icon
--                 [''] = ' ',     -- Visual Block mode icon
--                 ['c'] = ' ',      -- Command mode icon
--                 ['s'] = ' ',      -- Select mode icon
--                 ['S'] = ' ',      -- Select Line mode icon
--                 [''] = ' ',     -- Select Block mode icon
--                 ['R'] = ' ',      -- Replace mode icon
--                 ['Rv'] = ' ',     -- Virtual Replace mode icon
--                 ['t'] = ' ',      -- Terminal mode icon
--               }
--               return mode_icons[vim.fn.mode()] .. str
--             end,
--             separator = { right = '' },
-- 						color = {gui = 'bold'},
-- 						right_padding = -10,
--             separator_color = { fg = '#ff5c57', bg = '#44f445' }
--           }
--         },
--         lualine_b = { 
-- 					{'filename',path = 4, 
-- 					symbols = {
-- 						modified = '[+]',      -- Text to show when the file is modified.
-- 						readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
-- 						unnamed = '[No Name]', -- Text to show for unnamed buffers.
-- 						newfile = '[New]',     -- Text to show for newly created file before first write
-- 					}
-- 				},
-- 					{'branch'} 
-- 				},
--         lualine_c = {
--           {
--             function()
--               local clients = vim.lsp.get_active_clients({ bufnr = 0 })
--               if next(clients) == nil then
--                 return 'No LSP'
--               end
--               local client_names = {}
--               for _, client in pairs(clients) do
--                 table.insert(client_names, client.name)
--               end
--               return table.concat(client_names, ', ')
--             end,
--             icon = ' LSP:',
--             -- Выравнивание по центру
--             cond = function()
--               return #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
--             end,
--             color = { fg = '#ffffff', gui = 'bold' },
--           }
--         },
--         lualine_x = {},
--         lualine_y = { 'filetype', 'progress' },
--         lualine_z = {
--           {
--             'location',
--             separator = { left = '', right = '' },
--             left_padding = 2,
--             separator_color = { fg = '#00ff00', bg = '#000000' } -- Пример цвета разделителя
--           }
--         }
--       },
--       inactive_sections = {
--         lualine_a = { 'filename' },
--         lualine_b = {},
--         lualine_c = {},
--         lualine_x = {},
--         lualine_y = {},
--         lualine_z = { 'location' }
--       },
--       tabline = {},
--       extensions = {}
--     }
--
--     vim.cmd([[
--     augroup lualine_augroup
--       autocmd!
--       autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
--     augroup END
--     ]])
--   end
-- }
