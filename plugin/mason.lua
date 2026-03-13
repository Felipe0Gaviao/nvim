Pack({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		-----------
		-- LSPs
		-----------

		-- Lua
		"lua_ls",

		-- Python
		"basedpyright",

		-- Web Things
		"vtsls",

		-- Markdown
		"markdown-oxide",

		-- Rust
		"rust-analyzer",

		---------------------------
		-- Formatters
		---------------------------

		-- Web-related code styling
		"biome",

		-- Neovim lua config editing
		"stylua",

		-- TOML editing
		"taplo",

		-- Python
		"ruff",

		-- Jinja formatter
		-- Might be necessary later
		-- "djlint",
	},
	auto_update = true,
	run_on_start = true,
})

vim.lsp.config("dartls", {
	cmd = { "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	root_markers = { "pubspec.yaml" },

	init_options = {
		closingLabels = true,
		flutterOutline = true,
		onlyAnalyzeProjectsWithOpenFiles = true,
		outline = true,
		suggestFromUnimportedLibraries = true,
	},
})

vim.lsp.enable("dartls")
