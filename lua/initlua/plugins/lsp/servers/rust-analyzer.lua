local check = {}

-- Use clippy if it's installed
local Job = require("plenary.job")
Job:new({
	command = "cargo",
	args = { "clippy", "-V" },
	on_exit = function(_, code)
		if code == 0 then
			check = {
				allFeatures = true,
				overrideCommand = {
					"cargo",
					"clippy",
					"--workspace",
					"--message-format=json",
					"--all-targets",
					"--all-features",
					"--",
					"-Wclippy::pedantic",
					"-Wclippy::nursery",

					"-Wclippy::create_dir",
					"-Wclippy::empty_structs_with_brackets",
					"-Wclippy::filetype_is_file",
					-- "-Wclippy::format_push_string",
					"-Wclippy::get_unwrap",
					"-Wclippy::indexing_slicing",
					"-Wclippy::impl_trait_in_params",
					"-Wclippy::lossy_float_literal",
					"-Wclippy::str_to_string",
					"-Wclippy::string_add",
					"-Wclippy::string_to_string",
					"-Wclippy::suspicious_xor_used_as_pow",
					"-Wclippy::unneeded_field_pattern",
					"-Wclippy::unnecessary_self_imports",
					"-Wclippy::unseparated_literal_suffix",
					-- "-Wclippy::wildcard_enum_match_arm",

					-- 	"-Wclippy::unwrap_used",
					-- 	"-Wclippy::expect_used",

					"-Aclippy::missing_errors_doc",
					"-Aclippy::missing_panics_doc",
					"-Aclippy::must_use_candidate",
				},
			}
		else
			initlua.notify("rust-clippy is not installed", vim.log.levels.WARN)
		end
	end,
}):sync()

return {
	settings = {
		["rust-analyzer"] = {
			check = check,
		},
	},
}
