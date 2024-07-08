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
vim.keymap.set("n", "<leader>fO", "<cmd>Oil<CR>", { noremap = true, silent = true,               desc = "Toggle Yazi" })
vim.keymap.set("n", ")", "$", { noremap = true, silent = true,                                    desc = "Go to end of line" })
vim.keymap.set("n", "<C-'>", "<C-y>", { noremap = true, silent = true,                            desc = "Move screen up" })
vim.keymap.set("n", "<C-;>", "<C-e>", { noremap = true, silent = true,                            desc = "Move screen down" })
vim.keymap.set("n", "<BS>", "<C-o>", { noremap = true, silent = true,                        desc = "Move cursor to previous place" })

-- WINDOW MANAGEMENT
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true,                           desc = "Move window focus left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true,                           desc = "Move window focus down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true,                           desc = "Move window focus up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true,                           desc = "Move window focus right" })
vim.keymap.set("n", "<C-m>", "<C-w>v", { noremap = true, silent = true,                           desc = "Open window horizontally split" })
vim.keymap.set("n", "<C-n>", "<C-w>s", { noremap = true, silent = true,                           desc = "Open window vertically split" })
vim.keymap.set("n", "<C-q>", "<C-w>q", { noremap = true, silent = true,                           desc = "Close focused window" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true,                  desc = "Horizontally shrink focused window" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true,                desc = "Vertically shrink focused window" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true,       desc = "Horizontally grow focused window" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true,      desc = "Vertically grow focused window" })

-- TELESCOPE
vim.keymap.set("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", { noremap = true, silent = true,   desc = "Telescope: Find Files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep hidden=true<CR>", { noremap = true, silent = true,    desc = "Telescope: Live Grep" })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles hidden=true<CR>", { noremap = true, silent = true,     desc = "Telescope: Recent Files" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers hidden=true<CR>", { noremap = true, silent = true,      desc = "Telescope: Buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags hidden=true<CR>", { noremap = true, silent = true,    desc = "Telescope: Buffers" })

-- GIT
vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true,  desc = "Git Preview Hunk" })

-- UNIX INTEGRATION
vim.keymap.set("n", "<leader>od!", ":Delete!<CR>", { noremap = true, silent = true,   desc = "Delete file and buffer" })
vim.keymap.set("n", "<leader>or", ":Rename ", { noremap = true, silent = true,   desc = "Rename file and buffer" })
vim.keymap.set("n", "<leader>om", ":Move ", { noremap = true, silent = true,   desc = "Move file and buffer" })
vim.keymap.set("n", "<leader>oc", ":Copy ", { noremap = true, silent = true,   desc = "Copy file and buffer" })
vim.keymap.set("n", "<leader>od", ":Mkdir ", { noremap = true, silent = true,    desc = "Create directory" })
vim.keymap.set("n", "<leader>op", ":pwd<CR>", { noremap = true, silent = true,   desc = "Print working directory" })

-- LSP
-- vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { noremap = true, silent = true,   desc = "Print working directory" })
-- vim.keymap.set("n", "<leader>ld", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true,   desc = "Print working directory" })
-- vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, { noremap = true, silent = true,   desc = "Print working directory" })

                                -- INSERT MODE --


                                -- VISUAL MODE --
-- MISCELLANEOUS
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true,                                  desc = "Increase line indent" })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true,                                  desc = "Decrease line indent" })
