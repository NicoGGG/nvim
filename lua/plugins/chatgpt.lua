return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local chatgpt = require("chatgpt")
    chatgpt.setup({
      api_key_cmd = "pass show dev/openaikey/main",
      popup_input = {
        submit = "<C-e>",
      },
    })
  end,
}
