Pack({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local treesitter = require("nvim-treesitter")

local ensure_installed = {
	-- queries-only, invisible to FileType autocmd
	"ecma",
	"html_tags",
	"jsx",
	"jsdoc",
	"javadoc",
	-- git files that may not auto-trigger cleanly
	"git_config",
	"git_rebase",
	"gitcommit",
	"gitignore",
	"gitattributes",
	-- preload for your stack
	"java",
	"properties",
	"ini",
	"ssh_config",
	"desktop",
	"editorconfig",
	"xml",
}
treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang then
			return
		end

		local function start(buf, l)
			if pcall(vim.treesitter.language.add, l) then
				vim.treesitter.start(buf)
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end
		end

		if vim.tbl_contains(treesitter.get_installed(), lang) then
			start(ev.buf, lang)
		elseif vim.tbl_contains(treesitter.get_available(), lang) then
			treesitter.install({ lang }):await(function()
				start(ev.buf, lang)
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript" },
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

require("treesitter-context").setup({ mode = "topline" })
