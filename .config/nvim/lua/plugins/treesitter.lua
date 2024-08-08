return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "lua",
        "python",
        "c",
        "cpp",
        "rasi",
        "hyprlang",
      },
      highlight = {
        enable = true,
        disable = {
          "latex",
        },
      },
      highlight = {enable = true},
      indent = {enable = true},
    })
  end
}
