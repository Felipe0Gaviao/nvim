Pack({ "https://github.com/CRAG666/code_runner.nvim" })

local runners = {
	python = "uv run $file",
	rust = "cargo run",
	nim = "nim c -r",
}

require("lze").load({
	{
		"code_runner.nvim",
		ft = vim.tbl_keys(runners),
		after = function()
			require("code_runner").setup({ filetype = runners })
			vim.keymap.set("n", "<leader>rr", "<cmd>RunCode<cr>", { desc = "Run current file" })
		end,
	},
})
