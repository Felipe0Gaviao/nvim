return {
	--- @type lspconfig.settings.basedpyright
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticSeverityOverrides = {
					reportUnusedFunction = false,
					reportUnusedImport = false,
					reportUnusedVariable = false,
				},
			},
		},
	},
}
