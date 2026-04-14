return {
	--- @type lspconfig.settings.jsonls
	json = {
		spchemas = require("schemastore").json.schemas(),
		validate = { enable = true },
	},
}
