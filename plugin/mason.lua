Pack({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/b0o/SchemaStore.nvim",
})
local lsps = {
	"jsonls",
	"lua_ls",
	"basedpyright",
	"vtsls",
	"markdown-oxide",
	"rust-analyzer",
	"nimlsp",
}

local formatters = {
	"prettier",
	"stylua",
	"taplo",
	"ruff",
	"djlint",
}
-- Make sure taplo loads the squemas if there is one
vim.lsp.config("taplo", {
	root_dir = vim.fn.expand("~"),
})

vim.lsp.config("nimls", {
	cmd = { "nimlsp", vim.fn.expand("~/.choosenim/toolchains/nim-2.2.10") },
})

require("lze").load({
	{
		"mason.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-tool-installer").setup({
				ensure_installed = vim.list_extend(lsps, formatters),
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
})
