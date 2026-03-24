Pack({
	"https://github.com/CRAG666/code_runner.nvim",
})

require("code_runner").setup({
	filetype = {
		python = "uv run $file",
		rust = "cargo run",
	},
})

Map("n", "<leader>rr", "<cmd>RunCode<cr>")
