Pack({
	{
		src = "https://github.com/neovim/nvim-lspconfig",
	},
	{
		src = "https://github.com/mason-org/mason.nvim",
	},
	{
		src = "https://github.com/mfussenegger/nvim-lint",
	},
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
	},
	{
		src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	{
		src = "https://github.com/rshkarin/mason-nvim-lint",
	},
})

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = {
			"ruff",
		},
	},
})
require("mason-tool-installer").setup({
	ensure_installed = {
		-----------
		-- LSPs
		-----------

		-- Lua
		"lua_ls",

		-- Python
		"basedpyright",

		-- (Type|Java)script
		"vtsls",

		-- JSON
		"json-lsp",

		-- Markdown
		"markdown-oxide",

		---------------------------
		-- Formatters
		---------------------------

		-- (java|type)script-related code styling
		"prettier",

		-- Neovim lua config editing
		"stylua",

		-- TOML editing
		"taplo",

		-- Jinja formatter
		-- Might be necessary later
		-- "djlint",
	},
	auto_update = true,
	run_on_start = true,
})

local lint = require("lint")
lint.linters_by_ft = {
	python = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()
	end,
})

require("mason-nvim-lint").setup({
	ensure_installed = {
		-- python
		"ruff",
	},
	automatic_installation = true,
})
