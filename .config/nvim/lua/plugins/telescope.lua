return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local builtin = require("telescope.builtin")
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",
              ["<C-q>"] = "close",
              ["<C-m>"] = "select_vertical",
              ["<C-n>"] = "select_horizontal",
              ["<C-t>"] = "select_tab",
            }
          }
        }
      }
    end
  },
}
