
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local themes = {
  require("neovim.themes.catppuccin"),
  --require("themes.gruvbox"),
  -- добавьте другие темы...
}

require("lazy").setup({
  -- opts = {
  --   colorscheme = "tokyonight",
  --   news = {
  --     lazyvim = true,
  --     neovim = true,
  --   },
  -- },
  unpack(themes), -- подключаем все темы
  { import = "neovim.plugins" },
  --{ import = "ide.plugins.lsp" },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

--vim.cmd.colorscheme("gruvbox")
vim.cmd([[colorscheme catppuccin]])
