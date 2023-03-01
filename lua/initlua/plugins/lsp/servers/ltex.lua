return {
	settings = {
		ltex = {
			-- https://valentjn.github.io/ltex/advanced-usage.html#magic-comments
			language = "en-US",
			additionalRules = {
				motherTongue = "ru-RU",
				enablePickyRules = true,
			},
			completionEnabled = true,
			disabledRules = {
				["en-US"] = {
					-- Write notes peacefully
					"UPPERCASE_SENTENCE_START",
					-- "I can use whatever symbol I want!"
					"COPYRIGHT",
					-- I think nobody uses these quotes digitally...
					"EN_QUOTES",
					-- I love passive voice!
					"PASSIVE_VOICE",
				},
			},
		},
	},
}
