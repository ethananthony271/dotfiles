return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "hyprlang",
        "json",
        "kdl",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "rasi",
        "vim",
        "vimdoc",
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
