return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            win_options = {
                wrap = false,
            },
            keymaps = {
                ["<leader>?"]       = { "actions.show_help",                                desc = "Show help" },
                ["<CR>"]            = { "actions.select",                                   desc = "Enter file for directory" },
                ["-"]               = { "actions.parent",                                   desc = "Go to parent directory" },
                ["m<CR>"]           = { "actions.select", opts = { vertical = true },       desc = "Open the entry in a vertical split" },
                ["n<CR>"]           = { "actions.select", opts = { horizontal = true },     desc = "Open the entry in a horizontal split" },
                ["<leader>p"]       = { "actions.preview", opts = { vertical = true },      desc = "Preview the currently selected item" },
                -- TODO: Find a better way to quit oil
                ["gq"]              = { "actions.close",                                    desc = "Close Oil buffer" },
                ["<leader>r"]       = { "actions.refresh",                                  desc = "Refresh Oil buffer" },
                ["<leader>s"]       = { "actions.change_sort",                              desc = "Change sorting method" },
                ["<leader>x"]       = { "actions.open_external",                            desc = "Open item externally" },
                ["<leader>."]       = { "actions.toggle_hidden",                            desc = "Toggle hidden files" },
                ["<leader>\\"]      = { "actions.toggle_trash",                             desc = "Show trash" },
            },
            use_default_keymaps = false,
            is_always_hidden = function()
                return ".stfolder"
            end,
        })
    end
}
