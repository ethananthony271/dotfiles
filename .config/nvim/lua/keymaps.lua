-- TODO: Get some keymaps setup with vim_commentary
-- TODO: Map H and L to front and end of line

                              -- KEYMAP SETTINGS --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

                                -- NORMAL MODE --
-- MISCELLANEOUS
vim.keymap.set("n", "<leader>h", ":nohl<CR>", { noremap = true, silent = true,                    desc = "Clear Highlighting" })
vim.keymap.set("n", "U", "<C-r>", { noremap = true, silent = true,                                desc = "Redo" })
vim.keymap.set("n", "<leader>fo", "<cmd>Yazi<CR>", { noremap = true, silent = true,               desc = "Toggle Yazi" })

-- WINDOW MANAGEMENT
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true,                           desc = "Move window focus left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true,                           desc = "Move window focus down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true,                           desc = "Move window focus up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true,                           desc = "Move window focus right" })
vim.keymap.set("n", "<C-n>", "<C-w>v", { noremap = true, silent = true,                           desc = "Open window horizontally split" })
vim.keymap.set("n", "<C-m>", "<C-w>s", { noremap = true, silent = true,                           desc = "Open window vertically split" })
vim.keymap.set("n", "<C-q>", "<C-w>q", { noremap = true, silent = true,                           desc = "Close focused window" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true,                  desc = "Horizontally shrink focused window" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true,                desc = "Vertically shrink focused window" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true,       desc = "Horizontally grow focused window" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true,      desc = "Vertically grow focused window" })

-- TELESCOPE
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true,   desc = "Telescope: Find Files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true,    desc = "Telescope: Live Grep" })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { noremap = true, silent = true,     desc = "Telescope: Recent Files" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true,      desc = "Telescope: Buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = true,    desc = "Telescope: Buffers" })

-- GIT
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true,   desc = "Telescope: Find Files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true,    desc = "Telescope: Live Grep" })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { noremap = true, silent = true,     desc = "Telescope: Recent Files" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true,      desc = "Telescope: Buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = true,    desc = "Telescope: Buffers" })

                                -- INSERT MODE --
-- vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", { noremap = true, silent = true,              desc = "Git Add" })
-- vim.keymap.set("n", "<leader>gs", ":Git status<CR>", { noremap = true, silent = true,             desc = "Git Status" })
-- vim.keymap.set("n", "<leader>gd", ":Git diff<CR>", { noremap = true, silent = true,               desc = "Git Diff" })
-- vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { noremap = true, silent = true,             desc = "Git Commit" })
-- vim.keymap.set("n", "<leader>gb", ":Git branch<CR>", { noremap = true, silent = true,             desc = "Git Branch" })
-- vim.keymap.set("n", "<leader>go", ":Git checkout<CR>", { noremap = true, silent = true,           desc = "Git Checkout" })
-- vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { noremap = true, silent = true,               desc = "Git Push" })
-- vim.keymap.set("n", "<leader>gm", ":Git merge<CR>", { noremap = true, silent = true,              desc = "Git Merge" })
vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true,  desc = "Git Preview Hunk" })


                                -- VISUAL MODE --
-- MISCELLANEOUS
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true,                                  desc = "Increase line indent" })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true,                                  desc = "Decrease line indent" })
