Pack({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		javascript = { "biome" },
		typescript = { "biome" },
		toml = { "taplo" },
		json = { "biome" },
		yaml = { "biome" },
		markdown = { "biome" },
		rust = { "rustfmt" },
	},

	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
