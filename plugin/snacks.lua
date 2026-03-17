Pack({
	"https://github.com/folke/snacks.nvim",
})

local Snacks = require("snacks")
Snacks.setup({
	lazygit = {
		enabled = true,
	},
})

Map("n", "<leader>gg", Snacks.lazygit.open, { desc = "Lazygit Snacks Integration" })

