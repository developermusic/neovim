return {
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup{
				  ensure_installed = {
						"vim",
						"lua",
						"vimdoc",
						"html",
						"css",
						"javascript",
						"typescript",
						"tsx",
						"astro",
						"svelte",
						"rust",
						"dockerfile",
						"make",
				},
				sync_install = true,
				auto_install = true,

				highlight = {
					enable = true,
					use_languagetree = true,
					additional_vim_regex_highlighting = false, -- Используется только Tree-sitter
				},

				indent = { enable = true },
			}

			require("nvim-treesitter.parsers").get_parser_configs().astro = {
				install_info = {
					url = "https://github.com/virchau13/tree-sitter-astro", -- URL парсера
					files = { "src/parser.c", "src/scanner.c" },
					branch = "main",
				},
				filetype = "astro",
			}

		end
}