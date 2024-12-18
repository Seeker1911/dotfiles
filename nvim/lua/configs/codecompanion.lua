-- require("codecompanion").setup({
return {
	adapters = {
		openai = function()
			return require("codecompanion.adapters").extend("openai", {
				env = {
					api_key = "cmd:op read op://Private/'open api key new'/password --no-newline",
				},
			})
		end,
	},
}
-- )
