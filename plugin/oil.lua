Pack({
	"https://github.com/stevearc/oil.nvim",
}, {
	load = true,
	confirm = false,
})

require("oil").setup()

Map("n", "<leader>e", "<cmd>Oil<cr>")
