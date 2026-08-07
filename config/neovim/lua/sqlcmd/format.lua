local M = {}

local function trim(s)
	return s:match("^%s*(.-)%s*$") or ""
end

local function is_separator_line(t)
	return t:gsub("[%s|]", ""):match("^%-+$")
end

local function is_rows_affected(t)
	return t:match("%d+ rows? affected")
end

local function is_boundary(t)
	return t == "" or is_rows_affected(t)
end

local function parse_cells(t)
	return vim.iter(vim.split(t, "|", { plain = true })):map(trim):totable()
end

local function write_table_header(file, cells)
	file:write("| " .. table.concat(cells, " | ") .. " |\n")
	local seps = vim.iter(cells)
		:map(function()
			return "---"
		end)
		:totable()
	file:write("| " .. table.concat(seps, " | ") .. " |\n")
end

function M.write_stream(raw, out_path, max_rows)
	local file, err = io.open(out_path, "w")
	if not file then
		return nil, "Cannot open output file: " .. err
	end

	local lines = vim.split(raw, "\n", { plain = true })
	local row_count = 0
	local total_found = 0
	local in_table = false
	local needs_blank = false
	local has_output = false

	for _, line in ipairs(lines) do
		local t = trim(line)

		if is_boundary(t) then
			if in_table then
				in_table = false
				needs_blank = true
			end
		elseif is_separator_line(t) then
		elseif not in_table then
			if needs_blank then
				file:write("\n")
			end
			local cells = parse_cells(t)
			write_table_header(file, cells)
			in_table = true
			has_output = true
		else
			total_found = total_found + 1
			if row_count < max_rows or max_rows == 0 then
				local cells = parse_cells(t)
				file:write("| " .. table.concat(cells, " | ") .. " |\n")
				row_count = row_count + 1
			end
		end
	end

	file:close()

	if not has_output then
		os.remove(out_path)
		return 0, 0
	end

	return row_count, total_found
end

return M
