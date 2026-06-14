data:extend({
	{
		type = "int-setting",
		name = "flare-stack-fluid-rate",
		setting_type = "startup",
		default_value = 15,
		minimum_value = 1,
	},
	{
		type = "int-setting",
		name = "flare-stack-item-rate",
		setting_type = "startup",
		default_value = 2,
		minimum_value = 1,
		maximum_value = 60,
	},
	{
		type = "bool-setting",
		name = "flare-stack-disable-incinerators",
		setting_type = "startup",
		default_value = mods["space-age"] ~= nil,
	},
})
