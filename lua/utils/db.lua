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

return {
	format_config = format_config,
}
