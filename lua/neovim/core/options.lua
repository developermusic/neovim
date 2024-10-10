local opt = vim.opt
local o = vim.o
local g = vim.g

g.mapleader = " "
-- g.maplocalleader = "\\"

-- Высота нижней панели с сообщенями, если надо увеличить
-- opt.cmdheight = 2

opt.confirm = true -- Confirm to save changes before exiting modified buffer

opt.mouse = "a" -- Enable mouse mode
-- o.mouse = "a"
opt.mousefocus = true

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

--Устанавливает режим отображения статусной строки. Значение 2 означает, что статусная строка будет всегда отображаться, даже если есть только одно окно.
opt.laststatus = 3 -- global statusline
-- o.laststatus = 3
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions

opt.cursorline = true -- Enable highlighting of the current line
-- o.cursorline = true
o.cursorlineopt = "both" -- "number" -- Если стоит number, то выделяться будет только колонка с цифрами,а не вся строка
opt.scrolloff = 30 -- При скролле курсор всегда по центру
-- -- Эта опция позволяет настроить, какие части строки должны быть выделены line | number
opt.wrap = true --  Wrap lines
opt.linebreak = true -- Wrap lines at convenient points

-- Indenting
opt.expandtab = false -- Use spaces instead of tabs
-- -- o.expandtab = true
opt.shiftwidth = 2 -- Size of an indent
-- o.shiftwidth = 2
opt.smartindent = true -- Insert indents automatically
-- o.smartindent = true
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
-- -- o.signcolumn = "yes"
opt.tabstop = 2 -- Number of spaces tabs count for
-- o.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true -- Ignore case
-- o.ignorecase = true
opt.smartcase = true -- Don't ignore case with capitals

-- Numbers
opt.relativenumber = true -- Relative line numbers
-- o.relativenumber = true
opt.number = true -- Print line number
opt.numberwidth = 2

-- disable nvim intro
opt.shortmess:append "sI"
--
opt.splitbelow = true -- Put new windows below current
-- o.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
-- o.splitright = true
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
-- o.timeoutlen = 400
opt.undofile = true
-- o.undofile = true
opt.undolevels = 10000

-- SWAP
opt.swapfile = false -- Отключен swap
-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 200 -- Save swap file and trigger CursorHold

-- Устанавливает кодировку файла по умолчанию в UTF-8 для сохранения файлов в этой кодировке.
opt.fileencoding = "utf-8"
--Устанавливает кодировку редактора в UTF-8, что позволяет работать с символами Unicode.
opt.encoding = "utf-8"

opt.termguicolors = true -- True color support

-- Use system clipboard for yanked text
vim.api.nvim_set_keymap("n", "y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true, silent = true })
-- Make sure paste still works from the system clipboard
vim.api.nvim_set_keymap("n", "p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", '"+p', { noremap = true, silent = true })
-- Restore normal behavior for cut and other operations
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "D", '"_D', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "D", '"_D', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "c", '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "c", '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "C", '"_C', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "C", '"_C', { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "x", '"_x', { noremap = true, silent = true })
--jvim.api.nvim_set_keymap("n", "X", '"_X', { noremap = true, silent = true })
--vim.api.nvim_set_keymap("v", "X", '"_X', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "s", '"_s', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "s", '"_s', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "S", '"_S', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "S", '"_S', { noremap = true, silent = true })

vim.cmd [[ let $PATH = $PATH . ':~/.local/share/nvim/mason/bin' ]]
