return {
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "basic",
				inlayHints = {
					callArgumentNames = true,
					functionReturnTypes = true,
					variableTypes = true,
				},
			},
		},
	},
}
