-- local discipline = require "neovim.utils.discipline"
-- discipline.cowboy()

-- z | shift + m - сворачивает все блоки и вложенные
-- z | shift + r - разворачиваети все блоки
-- z c - сворачивает блок, в котором мы
-- z o - развернет этот блок
-- == или когда выделен блок и = - то мы выравниваем строки по левому краю
-- g U W - сделать слово заглавнымии
-- g u w - сделать прописными
-- g U U - сделать всю строку заглавными
-- g u u - сделать всю строку прописными

-- :verbose nmap <C-a> -- Проверка занятости сочетаний

-- Как заменить слово в файле
-- :%s/foo/bar/g
-- % — означает, что команда будет применена ко всему файлу.
-- s — команда замены.
-- g — означает замену всех вхождений в каждой строке.
-- если в конце после g добавить c , то на каждом вхождении будет спрашивать подтверждение
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("v", "S-g", "G")

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy all text" })

-- MOVING IN INSERT MODE
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- MOVE STRINGS IN NORMAL AND VISUAL MODES
map("n", "<A-k>", ":m .-2<cr>==")
map("n", "<A-j>", ":m .+1<cr>==")
map("v", "<A-k>", ":m '<-2<cr>gv=gv")
map("v", "<A-j>", ":m '>+1<cr>gv=gv")

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<leader>wnt", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>wnr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- FORMATING
map("n", "<leader>fm", function()
	require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- COMMENT
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

--NEOTREE
-- map("n", "<C-\\>", "<cmd>Neotree float focus<CR>", { desc = "Explorer toggle" })              -- toggle file explorer
map("n", "<leader>e", "<cmd>Neotree float focus<CR>", { desc = "File explorer focus window" })

-- SPLIT WINDOW
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- RESIZE WINDOW
map("n", "<c-w><left>", "<c-w><")
map("n", "<c-w><right>", "<c-w>>")
map("n", "<c-w><up>", "<c-w>+")
map("n", "<c-w><down>", "<c-w>-")

-- SESSIONS
map("n", "<leader>wr", "<cmd>:SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
map("n", "<leader>ws", "<cmd>:SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

map("n", "<leader>pc", "<cmd>PickColor<cr>", { desc = "Pick Color", noremap = true, silent = true })
map("n", "<leader>pi", "<cmd>PickColorInsert<cr>", { desc = "Insert pick color", noremap = true, silent = true })

-- TESTS
map("n", "<leader>nt", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })

map("n", "<leader>nf", function()
	require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Run file test" })

map("n", "<leader>no", ":Neotest output<CR>", { desc = "Test output" })
map("n", "<leader>ns", ":Neotest summary<CR>", { desc = "Test summary" })

-- DEBUG
map("n", "<leader>du", function()
	require("dapui").toggle()
end, { desc = "Dedug UI" })

map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Breakpoint" })

map("n", "<leader>ds", function()
	require("dap").continue()
end, { desc = "Start" })

map("n", "<leader>dn", function()
	require("dap").step_over()
end, { desc = "Step over" })

-- keymap.set("n", "<C-j>", function()
-- 	vim.diagnostic.goto_next()
-- end, opts)
--
-- keymap.set("n", "<leader>r", function()
-- 	require("craftzdog.hsl").replaceHexWithHSL()
-- end)
--
map("n", "<leader>li", function()
	require("neovim.utils.lsp").toggleInlayHints()
end, { desc = "Toggle inlay hints" })

-- Use system clipboard for yanked text
map("n", "y", '"+y', { silent = true })
map("v", "y", '"+y', { silent = true })

-- Restore normal behavior for cut and other operations
map("n", "d", '"_d', { silent = true })
map("v", "d", '"_d', { silent = true })
map("n", "D", '"_D', { silent = true })
map("v", "D", '"_D', { silent = true })
map("n", "c", '"_c', { silent = true })
map("v", "c", '"_c', { silent = true })
map("n", "s", '"_s', { silent = true })
map("v", "s", '"_s', { silent = true })
map("n", "S", '"_S', { silent = true })
map("v", "S", '"_S', { silent = true })
map("n", "x", '"_x', { silent = true })
map("v", "X", '"_X', { silent = true })

-- Make sure paste still works from the system clipboard
map("n", "p", '"+p', { silent = true })
map("v", "p", '"+p', { silent = true })
map("v", "p", '"_dP', { silent = true }) -- Вставка поверх без изменения буфера
