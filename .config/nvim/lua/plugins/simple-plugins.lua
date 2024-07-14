-- vim-commentary
-- vim-eunuch
-- neominimap
-- lualine
-- markdown
-- yazi

return {
  {
    "tpope/vim-commentary",
    lazy = false,
  },
  {
    "tpope/vim-eunuch",
  },
  {
    "Isrothy/neominimap.nvim",
    enabled = true,
    lazy = false, -- WARN: NO NEED to Lazy load
    init = function()
      vim.opt.wrap = false -- Recommended
      vim.opt.sidescrolloff = 36 -- It's recommended to set a large value
      vim.g.neominimap = {
        auto_enable = false,
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto'
        }
      })
    end
  },
  {
    {
      'MeanderingProgrammer/markdown.nvim',
      name = 'render-markdown',
      dependencies = { 
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        require('render-markdown').setup({})
      end,
    },
  },
  {
    {
      "DreamMaoMao/yazi.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
      },
    },
  },
}
