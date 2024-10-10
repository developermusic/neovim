require("mason").setup {
	-- ensure_installed = {
	-- 	"lua-language-server",
	-- 	"stylua",
	-- 	"html-lsp",
	-- 	"css-lsp",
	-- 	"prettier",
	-- 	"astro",
	-- 	"rust-analyzer",
	-- 	"dockerls",
	-- 	"docker-compose-language-service",
	-- 	"checkmake",
	-- 	"emmet_ls",
	-- },

	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},

	keymaps = {
		toggle_server_expand = "<CR>",
		install_server = "i",
		update_server = "u",
		check_server_version = "c",
		update_all_servers = "U",
		check_outdated_servers = "C",
		uninstall_server = "X",
		cancel_installation = "<C-c>",
	},

	max_concurrent_installers = 10,
	-- PATH = "skip",
	PATH = "~/.local/share/nvim/mason/bin/",
}

require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls", -- Используйте новые имена, например 'lua_ls' вместо 'lua-language-server'
		"html",
		"cssls",
		"tsserver",
		"prismals",
		"astro",
		"svelte",
		"rust_analyzer",
		"pyright",
		"dockerls",
		"docker_compose_language_service",
		"jsonls",
		-- "emmet_ls",
		-- другие LSP серверы
	},
	automatic_installation = true, -- Эта опция включает автоматическую установку отсутствующих серверов
}

require("mason-tool-installer").setup {
	ensure_installed = {
		"stylua",
		"eslint_d",
		"prettier",
		"checkmake",
	},
	auto_update = false,
	run_on_start = true,
}
