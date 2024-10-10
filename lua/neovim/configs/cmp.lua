local cmp = require "cmp"

cmp.setup {
	completion = {
		completeopt = "menu,menuone",
	},

	window = {
		completion = cmp.config.window.bordered {
			winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
			scrollbar = false,
		},
		documentation = cmp.config.window.bordered {
			winhighlight = "Normal:CmpDoc",
		},
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},

	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-x>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),

		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},

		-- ["<Tab>"] = cmp.mapping(function(fallback)
		--        if cmp.visible() then
		--            cmp.select_next_item()
		--        else
		--            fallback()
		--        end
		--    end, {"i", "s"}),
		--    ["<S-Tab>"] = cmp.mapping(function(fallback)
		--        if cmp.visible() then
		--            cmp.select_prev_item()
		--        else
		--            fallback()
		--        end
		--    end, {"i", "s"})

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- elseif require("luasnip").expand_or_jumpable() then
				-- 	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
				-- elseif require("luasnip").jumpable(-1) then
				-- 	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		-- {name = 'vsnip'},
		-- { name = "emmet_vim" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
}
