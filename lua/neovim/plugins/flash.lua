return {
  -- Затемняет все когда нажимаем "f"
  "folke/flash.nvim",
  -- enabled = true,
  vscode = true,
  event = "VeryLazy",
  config = function()
    local flash = require("flash")

    flash.setup({
      opts = {
        search = {
          --Указывает, должны ли подсказки отображаться вперед или назад от текущего положения курсора.
          forward = true,
          --Указывает, разрешено ли отображение нескольких подсказок в разных окнах.
          multi_window = false,
          --Указывает, должен ли поиск подсказок завершаться при достижении конца файла и переходе на начало.
          wrap = true,
          --Указывает, следует ли обновлять подсказки в режиме реального времени при вводе пользователем.(При включении не работают прыжки "f")
          incremental = false,
        },
      },
    })
  end,
  keys = {
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    -- {
    --   "S",
    --   mode = { "n", "o", "x" },
    --   function()
    --     require("flash").treesitter()
    --   end,
    --   desc = "Flash Treesitter",
    -- },
    -- {
    --   "r",
    --   mode = "o",
    --   function()
    --     require("flash").remote()
    --   end,
    --   desc = "Remote Flash",
    -- },
    -- {
    --   "R",
    --   mode = { "o", "x" },
    --   function()
    --     require("flash").treesitter_search()
    --   end,
    --   desc = "Treesitter Search",
    -- },
    -- {
    --   "<c-s>",
    --   mode = { "c" },
    --   function()
    --     require("flash").toggle()
    --   end,
    --   desc = "Toggle Flash Search",
    -- },
  },
}
