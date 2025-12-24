return {
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
