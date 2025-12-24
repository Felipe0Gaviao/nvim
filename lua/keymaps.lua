local map = vim.keymap.set

map("n", "<leader>w", "<cmd>silent write<cr>")
map("n", "<leader>q", "<cmd>confirm quit<cr>")
map("n", "<leader>e", "<cmd>Oil<cr>")
map("n", "<leader>gs", "<cmd>Git status<cr>")
map("n", "<leader>ga", "<cmd>Git add .<cr>")
map("n", "<leader>gr", "<cmd>Git restore --staged .<cr>")
map("n", "<leader>gc", "<cmd>Git commit<cr>")
