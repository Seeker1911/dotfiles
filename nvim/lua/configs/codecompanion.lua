return {
	adapters = {
		openai = function()
			return require("codecompanion.adapters").extend("openai", {
				env = {
					api_key = "cmd:op read op://Private/'CodeCompanion.nvim OpenAPI KEY'/credential --no-newline",
				},
				strategies = {
					-- Change the default chat adapter
					chat = {
						adapter = "openai",
					},
				},
				adapters = {
					opts = {
						show_model_choices = true,
					},
				},
			})
		end,
	},
}
