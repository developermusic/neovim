return {
	'akinsho/toggleterm.nvim', version = "*", config = true,
	config = function()
		require('toggleterm').setup({
			-- Общие настройки
			open_mapping = [[<c-\>]],
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			persist_mode = true,
		})

		local Terminal = require('toggleterm.terminal').Terminal

		-- Вертикальный терминал
		local vertical_term = Terminal:new({
			direction = 'vertical',
			size = 20,
		})

		-- Горизонтальный терминал
		local horizontal_term = Terminal:new({
			direction = 'horizontal',
			size = 10,
		})

		-- Плавающий терминал
		local float_term = Terminal:new({
			direction = 'float',
			size = function(term)
				return vim.o.columns * 0.8, vim.o.lines * 0.8
			end,
		})

		-- Функция для закрытия всех терминалов
		function _G.close_all_terms()
			if vertical_term:is_open() then vertical_term:close() end
			if horizontal_term:is_open() then horizontal_term:close() end
			if float_term:is_open() then float_term:close() end
		end

		-- Функции для открытия терминалов
		function _G.toggle_vertical_term()
			close_all_terms()
			vertical_term:toggle()
		end

		function _G.toggle_horizontal_term()
			close_all_terms()
			horizontal_term:toggle()
		end

		function _G.toggle_float_term()
			close_all_terms()
			float_term:toggle()
		end

		-- Привязка команд к клавишам
		vim.api.nvim_set_keymap('n', '<Leader>tv', '<Cmd>lua _G.toggle_vertical_term()<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>th', '<Cmd>lua _G.toggle_horizontal_term()<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>tf', '<Cmd>lua _G.toggle_float_term()<CR>', { noremap = true, silent = true })

		-- Привязка клавиши 'q' для закрытия активного терминала
		vim.api.nvim_set_keymap('n', 'q', '<Cmd>lua _G.close_all_terms()<CR>', { noremap = true, silent = true })

		function _G.set_terminal_keymaps()
			local opts = {buffer = 0}
			vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
			vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
			vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
		end

		vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
	end
}
