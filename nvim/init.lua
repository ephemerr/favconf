vim.cmd('source ~/.config/nvim/legacy.vim')

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "opencode", -- Используем OpenCode для чата
      model = "opencode/deepseek-v4-flash-free"
    },
    inline = {
      adapter = "opencode", -- Используем OpenCode для инлайн-команд
      model = "opencode/deepseek-v4-flash-free"
    },
  },
  adapters = {
    opencode = function()
      return require("codecompanion.adapters").extend("acp", {
        command = "opencode",
        args = { "acp" },
      })
    end,
  },
})
