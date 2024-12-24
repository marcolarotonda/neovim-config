local get_config_lsp = function(t)
	local concat_table = {
		t.user,
		":",
		t.password,
		"@tcp(",
		t.ip,
		":",
		t.port,
		")/",
		t.schema,
	}
	return table.concat(concat_table)
end

local get_config_dadbod = function(t)
	local concat_table = {
		t.driver,
		"://",
		t.user,
		":",
		t.password,
		"@",
		t.ip,
		":",
		t.port,
		"/",
		t.schema,
	}
	return table.concat(concat_table)
end

local format_config = function(t)
	return {
		lsp_config = {
			driver = t.driver,
			dataSourceName = get_config_lsp(t),
		},
		dadbod_config = {
			name = t.db_alias,
			url = get_config_dadbod(t),
		},
	}
end

local get_config_list = function(ts)
	local to_return = {}
	to_return.for_dadbod = {}
	to_return.for_lsp = {}
	for index, value in ipairs(ts) do
		local formatted = format_config(value)
		to_return.for_dadbod[index] = formatted.dadbod_config
		to_return.for_lsp[index] = formatted.lsp_config
	end
	return to_return
end

return {
    get_config_list = get_config_list
}
