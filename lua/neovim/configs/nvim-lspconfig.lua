local map = vim.keymap.set

-- Выводит сообщение когда подключаемся к буферу(вкладке)
local function opts(desc)
	return { buffer = bufnr, desc = "LSP " .. desc }
end

local function on_attach(client, bufnr)
	print("LSP attached to buffer " .. bufnr)

	-- -- Настраиваем группы выделения для текста (всегда белый) и иконок (по типу проблемы)
	-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff0000" }) -- Красный для ошибок
	-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00" }) -- Оранжевый для предупреждений
	-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#00aaff" }) -- Синий для информации
	-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#00ff00" }) -- Зеленый для подсказок
	-- -- Настраиваем текст для всех типов диагностики (делаем его белым)
	-- vim.api.nvim_set_hl(0, "DiagnosticTextWhite", { fg = "#ffffff", bold = true })

	-- Функция, проводит проверку, что уведомление в нижней части будет только раз, чтоб потом не требовалось при переходе на новый буфер нажимать постоянно "Enter"
	local function notify_once(message)
		if not vim.g.notified_once then
			vim.notify(message)
			vim.g.notified_once = true
		end
	end

	-- Настройка inlay hints, если они поддерживаются сервером
	if client.server_capabilities.inlayHintProvider then
		vim.g.inlay_hints_visible = true
		-- Проверьте, существует ли функция inlay_hint
		if vim.lsp.inlay_hint then
			-- vim.lsp.inlay_hint.enable(true)
			-- Ниже вариант, если первый не сработает
			-- vim.lsp.inlay_hint(bufnr, true)

			-- Вместо активации хинтов, по дефолту, а сами хинты по сочетанию когда надо активируем.Вызов функции с принтом не останавливая работу Neovim
			notify_once "Inlay hints are supported, but not enabled by default."
		else
			print "Inlay hints function not available in this Neovim version"
		end
	else
		print "Inlay hints not supported by the server"
	end

	-- Автоматический вызов подсказок аргументов функции при вводе скобок
	-- vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

	if client.server_capabilities.signatureHelpProvider then
		local api = vim.api

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			-- border = "rounded",
			winblend = 0,
			style = "minimal",
			focusable = false,
			silent = true,
			max_height = 7,
		})

		local function check_triggeredChars(triggerChars)
			local cur_line = api.nvim_get_current_line()
			local pos = api.nvim_win_get_cursor(0)[2]
			local prev_char = cur_line:sub(pos - 0, pos - 0)
			local cur_char = cur_line:sub(pos, pos)

			for _, char in ipairs(triggerChars) do
				if cur_char == char or prev_char == char then
					return true
				end
			end
		end

		local group = api.nvim_create_augroup("LspSignature", { clear = false })
		api.nvim_clear_autocmds { group = group, buffer = bufnr }

		local triggerChars = client.server_capabilities.signatureHelpProvider.triggerCharacters

		api.nvim_create_autocmd("TextChangedI", {
			group = group,
			buffer = bufnr,
			callback = function()
				if check_triggeredChars(triggerChars) then
					vim.lsp.buf.signature_help()
				end
			end,
		})
	end

	-- Эти сочетания будут доступны только на тех языковых серверах, где есть on_attach, например в css такие комбинации не нужны
	map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
	map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
	map("n", "gt", vim.lsp.buf.type_definition, opts "Go to type definition")
	map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
	-- map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	map("n", "<S-l>", vim.lsp.buf.signature_help, opts "Show signature help")

	-- map('n', '<Leader>lr', vim.lsp.buf.rename, opts)
	map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts "Code action")
	map("n", "<Leader>lf", function()
		vim.lsp.buf.format { async = true }
	end, opts "Format")
end

local x = vim.diagnostic.severity
-- Настройка отображения диагностики LSP
vim.diagnostic.config {
	-- virtual_text = true, -- Отключение виртуального текста
	virtual_text = {
		prefix = "●", -- здесь можно указать любой символ вместо квадрата
		-- severity = nil,
		spacing = 2, -- настройка расстояния между символом и текстом
	},
	signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } }, -- Включение значков в боковой панели
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded", -- Форма окна с диагностикой
		source = "always", -- Показать источник диагностики
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

local lspconfig = require "lspconfig"
-- Если сервера установлены через Mason, то тогда прописывать такой путь до установленных серверов в Mason

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded", -- Добавляет закругленную рамку
	-- width = 80, -- Установите ширину окна
	-- height = 15, -- Установите высоту окна
})

-- local mason_path = vim.fn.stdpath "data" .. "/mason/bin/"

-- Определяем функцию organize_imports
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

-- Убедитесь, что функция get_typescript_server_path определена где-то в коде
local function get_typescript_server_path(root_dir)
	-- Реализуйте логику получения пути к серверу TypeScript
	return "./node_modules/typescript/lib" -- Замените на правильный путь
end

-- Подключаем сервера, автоматически установленные через mason-lspconfig
require("mason-lspconfig").setup_handlers {
	function(server_name)
		lspconfig[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end,

	-- Настройки для определённых серверов
	["ts_ls"] = function()
		lspconfig.ts_ls.setup {
			capabilities = capabilities,
			on_attach = on_attach,
			commands = {
				OrganizeImports = {
					organize_imports,
					description = "Organize Imports",
				},
			},
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		}
	end,

	["astro"] = function()
		lspconfig.astro.setup {
			capabilities = capabilities,
			on_attach = on_attach,
			-- cmd = { mason_path .. "astro-ls", "--stdio" },
			filetypes = { "astro" },
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
			init_options = {
				typescript = {}, -- Проверьте, нужны ли эти опции
			},
			on_new_config = function(new_config, new_root_dir)
				-- Проверьте, есть ли init_options и tsdk перед использованием
				if vim.tbl_get(new_config.init_options, "typescript") and not new_config.init_options.typescript.tsdk then
					new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
				end
			end,
		}
	end,

	["docker_compose_language_service"] = function()
		lspconfig.docker_compose_language_service.setup {
			-- cmd = { mason_path .. "docker-compose-langserver", "--stdio" },
			filetypes = { "yaml", "yml" },
			-- filetypes = { "yaml.docker-compose" },
			root_dir = lspconfig.util.root_pattern(
				"docker-compose.yaml",
				"docker-compose.yml",
				"compose.yaml",
				"compose.yml"
			),
			single_file_support = true,
			settings = {
				docker = {
					languageserver = {
						compose = {
							enable = true, -- Включаем поддержку Docker Compose
						},
						formatter = {
							ignoreMultilineInstructions = true,
						},
					},
				},
			},
		}
	end,

	["rust_analyzer"] = function()
		lspconfig.rust_analyzer.setup {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					checkOnSave = {
						command = "clippy",
					},
					-- Настройка inlay hints (вставок) для Rust
					inlayHints = {
						typeHints = {
							enabled = true,
						},
						parameterHints = {
							enabled = true,
						},
						chainingHints = {
							enabled = true,
						},
						closureReturnTypeHints = {
							enabled = true,
						},
					},
				},
			},
		}
	end,

	["pyright"] = function()
		lspconfig.pyright.setup {
			settings = {
				pyright = {
					-- Using Ruff's import organizer
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						-- Ignore all files for analysis to exclusively use Ruff for linting
						ignore = { "*" },
					},
				},
			},
		}
	end,

	["prismals"] = function()
		lspconfig.prismals.setup {
			-- cmd = { mason_path .. "prisma-language-server", "--stdio" },
		}
	end,

	["jsonls"] = function()
		lspconfig.jsonls.setup {
			capabilities = capabilities,
			-- cmd = { mason_path .. "vscode-json-language-server", "--stdio" },
			settings = {
				json = {
					validate = { enable = true },
				},
			},
		}
	end,

	["cssls"] = function()
		lspconfig.cssls.setup {
			capabilities = capabilities,
		}
	end,

	["lua_ls"] = function()
		lspconfig.lua_ls.setup {
			-- cmd = { mason_path .. "lua-language-server" },
			-- cmd = { "~/.local/share/nvim/mason/bin/lua-language-server" },
			-- enabled = false,
			single_file_support = true,
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
						library = {
							vim.fn.expand "$VIMRUNTIME/lua",
							vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
							vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
						},
					},
					completion = {
						workspaceWord = true,
						callSnippet = "Both",
					},
					misc = {
						parameters = {
							-- "--log-level=trace",
						},
					},
					hint = {
						enable = true,
						setType = false,
						paramType = true,
						paramName = "Disable",
						semicolon = "Disable",
						arrayIndex = "Disable",
					},
					doc = {
						privateName = { "^_" },
					},
					type = {
						castNumberToInteger = true,
					},
					diagnostics = {
						disable = { "incomplete-signature-doc", "trailing-space" },
						-- enable = false,
						groupSeverity = {
							strong = "Warning",
							strict = "Warning",
						},
						groupFileStatus = {
							["ambiguity"] = "Opened",
							["await"] = "Opened",
							["codestyle"] = "None",
							["duplicate"] = "Opened",
							["global"] = "Opened",
							["luadoc"] = "Opened",
							["redefined"] = "Opened",
							["strict"] = "Opened",
							["strong"] = "Opened",
							["type-check"] = "Opened",
							["unbalanced"] = "Opened",
							["unused"] = "Opened",
						},
						unusedLocalExclude = { "_*" },
					},
					format = {
						enable = true,
						defaultConfig = {
							indent_style = "space",
							indent_size = "2",
							continuation_indent_size = "2",
						},
					},
				},
			},
		}
	end,
}

-- lspconfig.emmet_ls.setup({
-- 	 cmd = {mason_path .. "emmet-ls", "--stdio" },
-- 	filetypes = { "html", "css", "typescriptreact", "javascriptreact", "astro" }
-- })
-- vim.api.nvim_create_autocmd('LspAttach', {
-- group = vim.api.nvim_create_augroup('UserLspConfig', {}),
-- callback = function(ev)
-- Enable completion triggered by <c-x><c-o>
-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

-- Global mappings для LSP
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "SetLocList (diagnostics list split)" })

map("n", "H", vim.lsp.buf.hover, opts "Hover float")
map("n", "K", vim.diagnostic.open_float, { noremap = true, silent = true }) -- Float diagnostics
-- map("n", "gr", vim.lsp.buf.references, opts "Show references")

-- print("LSP configuration completed")  -- Отладка: сообщает, что конфигурация завершена
-- 	end
