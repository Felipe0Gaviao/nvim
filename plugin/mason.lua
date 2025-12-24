vim.pack.add({
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
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		-----------
		-- LSPs
		-----------

		-- Lua lsp
		"lua_ls",

		-- Python
		"basedpyright",

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

		-- Jinja formatter
		-- Might be necessary later
		-- "djlint",

		-- TODO: find a way to disable the ruff lsp while maintaining linting
		-- and formatting capalities
		"ruff",
	},
	auto_update = true,
	run_on_start = true,
})
