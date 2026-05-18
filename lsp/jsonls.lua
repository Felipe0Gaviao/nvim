return {
	--- @type lspconfig.settings.jsonls
	json = {
		schemas = require("schemastore").json.schemas(),
		validate = { enable = true },
	},
}
