vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
}, {
	load = true,
	confirm = false,
})

require("oil").setup()
