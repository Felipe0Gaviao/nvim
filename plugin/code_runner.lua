Pack({ "https://github.com/CRAG666/code_runner.nvim" })

local runners = {
	python = "uv run $file",
	rust = "cargo run",
	nim = "nim r",
}

require("lze").load({
	{
		"code_runner.nvim",
		ft = vim.tbl_keys(runners),
		after = function()
			require("code_runner").setup({
				mode = "snacks",
				filetype = runners,
				root_markers = {
					{ "PINCE.sh", "sh PINCE.sh" },
				},
			})
			vim.keymap.set(
				"n",
				"<leader>rr",
				"<cmd>RunCode<cr>",
				{ noremap = true, silent = false, desc = "Run current file" }
			)
			vim.keymap.set(
				"n",
				"<leader>rp",
				"<cmd>RunProject<cr>",
				{ noremap = true, silent = false, desc = "Run current project" }
			)
		end,
	},
})
