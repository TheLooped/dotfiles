-- Lazy Bootstrap

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

local luv = vim.uv or vim.loop

if not luv.fs_stat(lazypath) then
   local output = vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
   }
   if vim.api.nvim_get_vvar "shell_error" ~= 0 then
      vim.api.nvim_err_writeln(
         "Error cloning lazy.nvim repository...\n\n" .. output
      )
   end

   local oldcmdheight = vim.opt.cmdheight:get()
   vim.opt.cmdheight = 1

   vim.notify "Please wait while plugins are installed..."
   vim.api.nvim_create_autocmd("User", {
      desc = "Load Mason and Treesitter after Lazy installs plugins",
      once = true,
      pattern = "LazyInstall",
      callback = function()
         vim.cmd.bw()
         vim.opt.cmdheight = oldcmdheight
         vim.tbl_map(
            function(module) pcall(require, module) end,
            { "nvim-treesitter", "mason" }
         )
         vim.notify "Mason is installing packages if configured, check status with `:Mason`"
      end,
   })
end
vim.opt.rtp:prepend(lazypath)

-- assign spec
local spec = {}
vim.list_extend(spec, { { import = "plugin" } })

-- Setup using spec
require("lazy").setup {
   spec = spec,
   defaults = { lazy = true },

   install = {
      colorscheme = { "slate" },
      missing = true,
   },
   performance = {
      cache = {
         enabled = true,
         path = vim.fn.stdpath "cache" .. "/lazy/cache",

         -- Once one of the following events triggers, caching will be disabled.
         disable_events = { "UIEnter", "BufReadPre" },
      },
      reset_packpath = true, -- reset the package path to improve startup time
      rtp = {
         reset = true, -- reset the runtime path to $VIMRUNTIME and the config directory
         disabled_plugins = {
            "2html_plugin",
            "tohtml",
            "getscript",
            "getscriptPlugin",
            "gzip",
            "logipat",
            "netrw",
            "netrwPlugin",
            "netrwSettings",
            "netrwFileHandlers",
            "matchit",
            "tar",
            "tarPlugin",
            "rrhelper",
            "spellfile_plugin",
            "vimball",
            "vimballPlugin",
            "zip",
            "zipPlugin",
            "tutor",
            "rplugin",
            "syntax",
            "synmenu",
            "optwin",
            "compiler",
            "bugreport",
            "ftplugin",
         },
      }, -- }}}
   },
}
