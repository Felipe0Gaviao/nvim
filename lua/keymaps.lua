local map = vim.keymap.set

-- Quality of Life
map("n", "<leader>w", "<cmd>silent write<cr>")
map("n", "<leader>q", "<cmd>confirm quit<cr>")
map({ "n", "i", "v", "t", "c" }, "<C-z>", "<Nop>", { silent = true })

-- Oil.nvim plugin
map("n", "<leader>e", "<cmd>Oil<cr>")

-- MiniGit from mini.nvim plugin
map("n", "<leader>gs", "<cmd>Git status<cr>")
map("n", "<leader>ga", "<cmd>Git add .<cr>")
map("n", "<leader>gr", "<cmd>Git restore --staged .<cr>")
map("n", "<leader>gc", "<cmd>Git commit<cr>")

-- Terminal from the toggleterm.nvim
map("n", "<leader>t", "<cmd>ToggleTerm<cr>")
