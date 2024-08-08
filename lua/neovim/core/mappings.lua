-- z | shift + m - сворачивает все блоки и вложенные
-- z | shift + r - разворачиваети все блоки
-- z c - сворачивает блок, в котором мы
-- z o - развернет этот блок
-- == или когда выделен блок и = - то мы выравниваем строки по левому краю
-- g U W - сделать слово заглавнымии
-- g u w - сделать прописными
-- g U U - сделать всю строку заглавными
-- g u u - сделать всю строку прописными
-- require "nvchad.mappings"
-- :verbose nmap <C-a> -- Проверка занятости сочетаний
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("v", "S-g", "G")

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

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

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

-- FORMATING
map("n", "<leader>fm", function()
	require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- GLOBAL LSP MAPPINGS
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })
map("n", "lk", vim.lsp.buf.hover, { noremap = true, silent = true })         -- Info on hover
map("n", "hj", vim.diagnostic.open_float, { noremap = true, silent = true }) -- Float diagnostics

-- BUFFERLINE
map("n", "<leader>b", " ", { desc = "Buffers" }) -- collapse file explorer
map("n", "<leader>x", function()
	require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<leader>bc", function()
	require("nvchad.tabufline").closeOtherBufs()
end, { desc = "Closes all bufs except current one" })
map("n", "<leader>bx", function()
	require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close All Buffers" })

map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- COMMENT
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

--NEOTREE
map("n", "<C-\\>", "<cmd>Neotree float focus<CR>", { desc = "Explorer toggle" })              -- toggle file explorer
map("n", "<leader>e", "<cmd>Neotree float focus<CR>", { desc = "Neotree focus window" })

-- NVIMTREE
--map("n", "<C-\\>", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer toggle" })              -- toggle file explorer
-- map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
-- map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
-- map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })   -- refresh file explorer

-- DIFFERENT
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

-- TERMINAL
-- map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("n", "<leader>t", " ", { desc = "Terminal" })
-- toggleable terminal
map({ "n", "t" }, "<leader>v", function()
	require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.3 }
end, { desc = "terminal toggleable vertical term" })
map({ "n", "t" }, "<leader>h", function()
	require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.3 }
end, { desc = "terminal toggleable horizontal term" })
map({ "n", "t" }, "<leader>\\", function()
	require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })
map("n", "<leader>tn", " ", { desc = "Create new terminal" }) -- new terminal window

-- SPLIT WINDOW
map("n", "<leader>s", " ", { desc = "Split window" })
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- RESIZE WINDOW
map("n", "<c-w><left>", "<c-w><")
map("n", "<c-w><right>", "<c-w>>")
map("n", "<c-w><up>", "<c-w>+")
map("n", "<c-w><down>", "<c-w>-")

-- SWITCH WINDOW
-- map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
-- map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
-- map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
-- map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<leader>wr", "<cmd>:SessionRestore<CR>", { desc = "Restore session for cwd" })             -- restore last workspace session for current directory
map("n", "<leader>ws", "<cmd>:SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- WHICHKEY
map("n", "<leader>wk", "<cmd>whichkey <cr>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })


map("n", "<leader>pc", "<cmd>PickColor<cr>", { desc = "Pick Color", noremap = true, silent = true })
map("n", "<leader>pi", "<cmd>PickColorInsert<cr>", { desc = "Insert pick color", noremap = true, silent = true })
