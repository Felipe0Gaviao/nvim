Pack({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

require("tiny-inline-diagnostic").setup({
	preset = "minimal",
	options = {
		show_source = {
			enabled = true,
			if_many = true,
		},
	},
})

vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
