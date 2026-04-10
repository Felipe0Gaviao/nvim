#!/usr/bin/env -S nvim -l
local config = vim.fn.stdpath("config")
for path in vim.fs.dir(config, { depth = math.huge }) do
	local full = config .. "/" .. path
	if not path:match("%.git") and vim.fn.isdirectory(full) == 0 then
		local f = io.open(full, "r")
		if f then
			print("=== " .. path .. " ===")
			print(f:read("*a"))
			f:close()
		end
	end
end
