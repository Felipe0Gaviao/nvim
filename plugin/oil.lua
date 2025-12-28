vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
}, {
	load = true,
	confirm = false,
})

require("oil").setup()

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")
