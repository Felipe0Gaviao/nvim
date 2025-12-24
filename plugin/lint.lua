vim.pack.add({
	{
		src = "https://github.com/mfussenegger/nvim-lint",
	},
})

local lint = require("lint")

lint.linters_by_ft = {
	markdown = { "markdownlint-cli2", "codespell" },
	lua = { "codespell" },
	toml = { "codespell" },
	json = { "codespell" },
	python = { "ruff", "codespell" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

lint.linters.codespell = require("lint.util").wrap(lint.linters.codespell, function(diagnostic)
	diagnostic.severity = vim.diagnostic.severity.HINT
	return diagnostic
end)
