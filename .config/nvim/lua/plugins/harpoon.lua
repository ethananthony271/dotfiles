return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        -- vim.keymap.set("n", "<leader>af", function() toggle_telescope(harpoon:list()) end, {                    desc = "Open telescope harpoon window" })
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, {                                 desc = "Add File to Harpoon" })
        vim.keymap.set("n", "<leader>s", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {         desc = "Open Harpoon Window" })
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {                             desc = "Open Harpoon Mark 1" })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {                             desc = "Open Harpoon Mark 2" })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {                             desc = "Open Harpoon Mark 3" })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {                             desc = "Open Harpoon Mark 4" })
        vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, {                             desc = "Open Harpoon Mark 5" })
        vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, {                             desc = "Open Harpoon Mark 6" })
        vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, {                             desc = "Open Harpoon Mark 7" })
        vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, {                             desc = "Open Harpoon Mark 8" })
        vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, {                             desc = "Open Harpoon Mark 9" })
        -- TODO: Get mark deleting to work in Harpoon
        -- vim.keymap.set("n", "<leader>d1", function() harpoon:list():removeAt(1) end, {                          desc = "Remove harpoon mark 1" })
        -- vim.keymap.set("n", "<leader>d2", function() harpoon:list():removeAt(2) end, {                          desc = "Remove harpoon mark 2" })
        -- vim.keymap.set("n", "<leader>d3", function() harpoon:list():removeAt(3) end, {                          desc = "Remove harpoon mark 3" })
        -- vim.keymap.set("n", "<leader>d4", function() harpoon:list():removeAt(4) end, {                          desc = "Remove harpoon mark 4" })
        -- vim.keymap.set("n", "<leader>d5", function() harpoon:list():removeAt(5) end, {                          desc = "Remove harpoon mark 5" })
    end
}
