Pack({
	{
		src = "https://github.com/stevearc/conform.nvim",
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		toml = { "taplo" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},

	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
})
