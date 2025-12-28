local map = vim.keymap.set

-- Quality of Life
map("n", "<leader>w", "<cmd>silent write<cr>")
map("n", "<leader>q", "<cmd>confirm quit<cr>")
map({ "n", "i", "v", "t", "c" }, "<C-z>", "<Nop>", { silent = true })

-- Oil.nvim plugin
map("n", "<leader>e", "<cmd>Oil<cr>")

-- Terminal from the toggleterm.nvim
map("n", "<leader>t", "<cmd>ToggleTerm<cr>")
