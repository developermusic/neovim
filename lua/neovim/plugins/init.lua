local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
	},
	{ "neovim/nvim-lspconfig", event = "BufReadPost" },

	-- Autocomplete support
	-- { "hrsh7th/nvim-cmp", event = "InsertEnter" },
	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	-- follow latest release.
	-- 	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- },
	-- load luasnips + cmp related in insert mode only
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					require "neovim.configs.luasnip"
				end,
			},
		},
	},
	-- cmp sources plugins
	{
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		cmd = "Telescope",
	},

	-- {
	-- 	"nvimdev/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("dashboard").setup {
	-- 			-- config
	-- 		}
	-- 	end,
	-- 	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	-- },

	{ "norcalli/nvim-colorizer.lua" },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
	},

	-- THEMES
	-- { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			background = {
				dark = "macchiato", -- macchiato // mocha // frappe
				light = "latte",
			},
		},
	},

	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},

	{ "akinsho/toggleterm.nvim", version = "*", config = true },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	-- {
	-- 	"folke/trouble.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	opts = {
	-- 		-- your configuration comes here
	-- 		-- or leave it empty to use the default settings
	-- 		-- refer to the configuration section below
	-- 	},
	-- },

	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		cmd = {
			"Tmuxnavigateleft",
			"Tmuxnavigatedown",
			"Tmuxnavigateup",
			"Tmuxnavigateright",
			"Tmuxnavigateprevious",
		},
		keys = {
			-- TMUX NAVIGATOR (Важно прописать "cmd", иначе не получится перепрыгивать на "pane" в tmux)
			{ "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux Right" },
			{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux Left" },
			{ "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Tmux Up" },
			{ "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Tmux Down" },
			{ "<c-p>", "<cmd>Tmuxnavigateprevious<cr>", desc = "Tmux Down" },
		},
	},

	{
		"kylechui/nvim-surround",
		event = { "bufreadpre", "bufnewfile" },
		version = "*", -- use for stability; omit to use `main` branch for the latest features
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		-- event = "User FilePost",
		main = "ibl",
	},
	-- Отвечает за разноцветные скобки,html теги и тд.
	{
		"HiPhish/rainbow-delimiters.nvim",
	},

	{
		"folke/flash.nvim",
		-- enabled = true,
		vscode = true,
		event = "VeryLazy",
		keys = {
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},

	{
		"rmagatti/auto-session",
		cmd = { "SessionSave", "SessionRestore" },
	},

	-- Выравнивание и перемещение текста
	-- Автоматическое открытие фигурных скобок, кавычек и т.д
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},

	{
		"windwp/nvim-ts-autotag",
		-- event = "InsertEnter",
	},

	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	},
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup {
				library = { plugins = { "nvim-dap-ui" }, types = true },
			}
		end,
	},

	-- GIT
	{
		"lewis6991/gitsigns.nvim",
	},

	{ "tpope/vim-fugitive" },

	{ "rbong/vim-flog", dependencies = {
		"tpope/vim-fugitive",
	}, lazy = false },

	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
	},
}
