local npairs = require "nvim-autopairs"
npairs.setup(opts)

-- setup cmp for autopairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("nvim-ts-autotag").setup()
-- 	opts = {
-- 		-- defaults
-- 		enable_close = true, -- Auto close tags
-- 		enable_rename = true, -- Auto rename pairs of tags
-- 		enable_close_on_slash = false -- Auto close on trailing </
-- 	},
-- 	-- Also override individual filetype configs, these take priority.
-- 	-- Empty by default, useful if one of the "opts" global settings
-- 	-- doesn't work well in a specific filetype
-- 	per_filetype = {
-- 		["html"] = {
-- 			enable_close = true
-- 		}
-- 	}
-- })

vim.lsp.handlers["textDocument/severity"] = vim.lsp.with(vim.lsp.diagnostic.severity, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})
