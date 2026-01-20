Pack({
	{
		src = "https://github.com/neovim/nvim-lspconfig",
	},
	{
		src = "https://github.com/mason-org/mason.nvim",
	},
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
	},
	{
		src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
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

		---------------------------
		-- Linters and Formatters
		---------------------------

		-- (java|type)script-related code styling
		"prettier",

		-- Neovim lua config editing
		"stylua",

		-- Code spell check for comments
		"codespell",

		-- TOML editing
		"taplo",

		-- Markdown
		"markdown-oxide",

		-- python
		"ruff",
		-- Jinja formatter
		-- Might be necessary later
		-- "djlint",
	},
	auto_update = true,
	run_on_start = true,
})
