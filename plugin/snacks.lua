Pack({ "https://github.com/folke/snacks.nvim" })

local Snacks = require("snacks")

Snacks.setup({
	bigfile = {
		enabled = true,
	},
	lazygit = {
		enabled = true,
	},
	rename = {
		enabled = true,
	},
	terminal = {
		enabled = true,
		win = {
			style = "float",
			border = "rounded",
			width = 0.8,
			height = 0.8,
		},
	},
	input = {
		enabled = true,
	},
})

vim.keymap.set("n", "<leader>gg", Snacks.lazygit.open, { desc = "Lazygit Snacks Integration" })
vim.keymap.set({ "n", "t" }, [[<C-\>]], function()
	Snacks.terminal.toggle()
end)
vim.keymap.set("n", "<leader>t", function()
	Snacks.terminal.toggle()
end, { desc = "Toggle Snacks terminal" })

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})
