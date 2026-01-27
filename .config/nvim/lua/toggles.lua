local M = {}

-- Your Personal Default Configuration
-- Edit these values directly to change your startup defaults.
local state = {
	diagnostics = false,
	virtual_lines = false,
	inlay_hints = false,
	git = true,
	todos = false,
	format_on_save = true,
	relativenumber = true,
	number = false,
	wrap = false,
	spell = false,
}

function M.setup(opts)
	-- Allow overrides if ever needed, but defaults come from the table above
	state = vim.tbl_extend("force", state, opts or {})

	-- Apply settings after UI enters
	vim.schedule(function()
		M.apply()
	end)
end

function M.apply()
	-- 1. Diagnostics (signs)
	-- Note: We preserve other diagnostic config by getting current config first if needed,
	-- but here we might want to enforce the toggle state.
	-- Since 'virtual_lines' is also a toggle, we need to be careful not to overwrite one with the other
	-- if we just pass a partial config. vim.diagnostic.config() merges.
	vim.diagnostic.config({
		signs = state.diagnostics,
		virtual_lines = state.virtual_lines,
	})

	-- 2. Git Signs
	local ok_gs, gs = pcall(require, "gitsigns")
	if ok_gs then
		gs.toggle_signs(state.git)
	end

	-- 3. Todo Comments
	-- Only update if already loaded to avoid forcing lazy-load on startup
	if package.loaded["todo-comments"] then
		local todo = require("todo-comments")
		local config = require("todo-comments.config")
		config.options.signs = state.todos
		todo.setup(config.options)
	end

	-- 4. Inlay Hints
	if vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(state.inlay_hints)
	end

	-- 5. Format on Save
	-- We use a global variable that formatting.lua respects
	vim.g.format_on_save = state.format_on_save

	-- 6. Vim Options (Window/Buffer local options)
	-- We apply these to the current window/buffer, but also set the global default
	-- so new windows inherit them.
	vim.opt.relativenumber = state.relativenumber
	vim.opt.number = state.number
	vim.opt.wrap = state.wrap
	vim.opt.spell = state.spell
end

function M.toggle(key)
	if state[key] == nil then
		vim.notify("Invalid toggle key: " .. key, vim.log.levels.ERROR)
		return
	end

	state[key] = not state[key]

	-- Apply specific changes immediately for better responsiveness
	if key == "diagnostics" then
		vim.diagnostic.config({ signs = state[key] })
	elseif key == "virtual_lines" then
		vim.diagnostic.config({ virtual_lines = state[key] })
	elseif key == "git" then
		local ok, gs = pcall(require, "gitsigns")
		if ok then
			gs.toggle_signs(state[key])
		end
	elseif key == "todos" then
		local ok, todo = pcall(require, "todo-comments")
		if ok then
			local config = require("todo-comments.config")
			-- Update the internal config state
			config.options.signs = state[key]
			-- Reload with the full config
			todo.setup(config.options)
			-- Force a redraw to update signs immediately
			vim.cmd("edit!")
		end
	elseif key == "inlay_hints" then
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(state[key])
		end
	elseif key == "format_on_save" then
		vim.g.format_on_save = state[key]
	elseif key == "relativenumber" then
		vim.opt.relativenumber = state[key]
	elseif key == "number" then
		vim.opt.number = state[key]
	elseif key == "wrap" then
		vim.opt.wrap = state[key]
	elseif key == "spell" then
		vim.opt.spell = state[key]
	end

	local status = state[key] and "enabled" or "disabled"
	vim.notify(key:gsub("^%l", string.upper):gsub("_", " ") .. " " .. status)
end

function M.get(key)
	return state[key]
end

return M
