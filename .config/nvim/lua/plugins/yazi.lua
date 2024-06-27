return {
  "DreamMaoMao/yazi.nvim",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  options = {
        default_file_explorer = true,
  },
  keys = {
    { "<leader>fo", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
  },
}
