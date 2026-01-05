vim.keymap.set("n", "<leader>r", function()
	local file = vim.fn.expand("%")
	require("toggleterm").exec("\x15py " .. file, 1)
end, { desc = "Run current python file" })
