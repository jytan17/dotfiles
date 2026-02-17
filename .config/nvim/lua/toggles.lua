local M = {}

-- Store autocmd IDs for cleanup
local diagnostic_hover_autocmd = nil

-- Your Personal Default Configuration
-- Edit these values directly to change your startup defaults.
local state = {
	diagnostics = false, -- This now controls both signs AND hover
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
	-- 1. Diagnostics (signs + hover)
	vim.diagnostic.config({
		signs = state.diagnostics,
	})

	-- Enable/disable diagnostic hover based on diagnostics state
	if state.diagnostics then
		M.enable_diagnostic_hover()
	else
		M.disable_diagnostic_hover()
	end

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
		-- Also toggle diagnostic hover
		if state[key] then
			M.enable_diagnostic_hover()
		else
			M.disable_diagnostic_hover()
		end
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

function M.enable_diagnostic_hover()
	-- Clear any existing autocmd first
	M.disable_diagnostic_hover()

	-- Create autocmd that shows diagnostic float on cursor hold
	diagnostic_hover_autocmd = vim.api.nvim_create_autocmd("CursorHold", {
		group = vim.api.nvim_create_augroup("DiagnosticHover", { clear = true }),
		callback = function()
			-- Check if there's a diagnostic on the current line
			local bufnr = vim.api.nvim_get_current_buf()
			local line = vim.api.nvim_win_get_cursor(0)[1] - 1
			local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })

			if #diagnostics > 0 then
				vim.diagnostic.open_float(nil, {
					scope = "cursor",
					focusable = false,
					close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
					border = "rounded",
					source = "always",
					prefix = " ",
					wrap = true,
				})
			end
		end,
	})
end

function M.disable_diagnostic_hover()
	-- Clear the autocmd group
	if diagnostic_hover_autocmd then
		vim.api.nvim_clear_autocmds({ group = "DiagnosticHover" })
		diagnostic_hover_autocmd = nil
	end
end

return M
