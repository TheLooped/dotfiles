-- Utility functions
local M = {}

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
    opts = opts or {}
    return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Get an icon from `lspkind` if it is available and return it.
---@param kind string The kind of icon in `lspkind` to retrieve.
---@return string icon.
function M.get_icon(kind, padding, no_fallback)
    if not vim.g.icons_enabled and no_fallback then return "" end
    local icon_pack = vim.g.icons_enabled and "icons" or "text_icons"
    if not M[icon_pack] then
        M.icons = require("util.icons")
    end
    local icon = M[icon_pack] and M[icon_pack][kind]
    return icon and icon .. string.rep(" ", padding or 0) or ""
end

--- Returns true if the file is considered a big file,
--- according to the criteria defined in `vim.g.big_file`.
---@param bufnr number|nil buffer number. 0 by default, which means current buf.
---@return boolean is_big_file true or false.
function M.is_big_file(bufnr)
  if bufnr == nil then bufnr = 0 end
  local filesize = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
  local nlines = vim.api.nvim_buf_line_count(bufnr)
  local is_big_file = (filesize > vim.g.big_file.size)
      or (nlines > vim.g.big_file.lines)
  return is_big_file
end

--- Resolve the options table for a given plugin with lazy
---@param plugin string The plugin to search for
---@return table opts # The plugin options
function M.plugin_opts(plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    local lazy_plugin_avail, lazy_plugin = pcall(require, "lazy.core.plugin")
    local opts = {}
    if lazy_config_avail and lazy_plugin_avail then
        local spec = lazy_config.spec.plugins[plugin]
        if spec then
            opts = lazy_plugin.values(spec, "opts")
        end
    end
    return opts
end

--- Map a key or set of keys to an action or a lua function
---@param modes string|table Modes for which the mapping should be active
---@param lhs string The key combination to map
---@param rhs string|function The action or lua function to execute
---@param opts table<string, any> (optional) A table of options
function M.map(modes, lhs, rhs, opts)
    local options = {
        noremap = true,
        silent = true,
        expr = false,
        desc = opts and opts.desc or nil,
    }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    modes = type(modes) == "string" and { modes } or modes

    local rhs_type = type(rhs)
    local rhs_value

    if rhs_type == "function" then
        rhs_value = string.format("<cmd>lua %s()<cr>", tostring(rhs))
    elseif rhs_type == "string" then
        rhs_value = rhs
    else
        error("Invalid rhs value. Expected a string or function.")
    end

    for _, mode in ipairs(modes) do
        if type(rhs) == "function" then
            local fn_str = string.format("<cmd>lua %s()<cr>", tostring(rhs))
            vim.api.nvim_set_keymap(mode, lhs, fn_str, options)
        else
            vim.api.nvim_set_keymap(mode, lhs, rhs, options)
        end

        if opts and opts.desc then
            options.desc = opts.desc
            vim.keymap.set(mode, lhs, rhs, options)
        end
    end
end

--- Convenient wrapper to trigger events.
---
---@param event_name string Name of the event.
---@param active boolean|nil If true, trigger directly instead of scheduling. Useful for startup events.
---@usage To run a User event: `trigger_event("User MyUserEvent")`
---@usage To run a Neovim event: `trigger_event("BufEnter")`
function M.trigger_event(event_name, activate)
    local function execute_event()
        local is_user_defined_event = event_name:match("^User ") ~= nil

        if is_user_defined_event then
            local user_defined_event_name = event_name:gsub("^User ", "")
            vim.api.nvim_exec_autocmds("User", { pattern = user_defined_event_name, modeline = false })
        else
            vim.api.nvim_exec_autocmds(event_name, { modeline = false })
        end
    end
    -- Execute the event
    if trigger_immediately then
        execute_event()
    else
        vim.schedule(execute_event)
    end
end

--- Helper function to require a module when running a function.
---@param plugin string The plugin to call `require("lazy").load` with.
---@param module table The system module where the functions live (e.g. `vim.ui`).
---@param func_names string|string[] The functions to wrap in
---                                  the given module (e.g. `{ "ui", "select }`).
function M.load_plugin_with_func(plugin, module, func_names)
    if type(func_names) == "string" then
        func_names = { func_names }
    end
    for _, func in ipairs(func_names) do
        local old_func = module[func]
        module[func] = function(...)
            module[func] = old_func
            require("lazy").load({ plugins = { plugin } })
            module[func](...)
        end
    end
end

--- Call function if a condition is met.
---@param func function The function to run.
---@param condition boolean # Whether to run the function or not.
---@return any|nil result # the result of the function running or nil.
function M.conditional_func(func, condition, ...)
    -- if the condition is true or no condition is provided, evaluate
    -- the function with the rest of the parameters and return the result
    if condition and type(func) == "function" then
        return func(...)
    end
end

--- Serve a notification with a title of Omega
---@param msg string The notification body
---@param type? number The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
    vim.schedule(function()
        vim.notify(msg, type, M.extend_tbl({ title = "Omega" }, opts))
    end)
end

--- Run a shell command and capture the output and if the command
--- succeeded or failed
---@param cmd string|string[] The terminal command to execute
---@param show_error? boolean Whether or not to show an unsuccessful command
---                           as an error to the user
---@return string|nil # The result of a successfully executed command or nil
function M.cmd(cmd, show_error)
    if type(cmd) == "string" then
        cmd = vim.split(cmd, " ")
    end
    if vim.fn.has("win32") == 1 then
        cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd)
    end
    local result = vim.fn.system(cmd)
    local success = vim.api.nvim_get_vvar("shell_error") == 0
    if not success and (show_error == nil or show_error) then
        vim.api.nvim_err_writeln(
            ("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result)
        )
    end
    return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

--- Always ask before exiting nvim, even if there is nothing to be saved.
function M.confirm_quit()
    local choice = vim.fn.confirm("Do you really want to exit nvim?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.cmd("confirm quit")
    end
end

--- Check if a plugin is defined in lazy. Useful with lazy loading
--- when a plugin is not necessarily loaded yet.
---@param plugin string The plugin to search for.
---@return boolean available # Whether the plugin is available.
function M.has(plugin)
    local available, config = pcall(require, "lazy.core.config")
    return available and config.spec.plugins[plugin] ~= nil
end

return M
