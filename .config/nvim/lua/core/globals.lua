-- Global variables
local global = {}

-- global functions

--@param msg string
--@param level number
--@return nil
--@usage
--global.notify("hello", vim.log.levels.WARN)
function global.notify(msg, level) vim.notify(msg, level, { title = "Lax" }) end

function global:load_variables()
    self.cache_dir = vim.fn.stdpath "cache"
    self.data_dir = string.format("%s/site/", vim.fn.stdpath "data")
    self.vim_path = vim.fn.stdpath "config"
    self.colorscheme = "tokyodark"
    self.mapleader = " "
    self.maplocalleader = " "
end

global:load_variables()

return global
