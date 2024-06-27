-- icons used by other plugins
-- stylua: ignore
local icons = {

    -- File icons
    file = {
        Default   = "󰈙",
        New       = "",
        Modified  = "",
        Read_only = "",
    },

    -- Folder icons
    folder = {
        Default = "",
        Empty   = "",
        Open    = "",
        Closed  = "",
    },

    -- Git icons
    git = {
        Default   = "󰊢",
        Add       = "",
        Branch    = "",
        Change    = "",
        Conflict  = "",
        Delete    = "",
        Ignored   = "◌",
        Renamed   = "➜",
        Sign      = "▎",
        Staged    = "✓",
        Unstaged  = "✗",
        Untracked = "",
    },

    -- Diagnostic icons
    diagnostic = {
        Error = "",
        Warn  = "",
        Info  = "",
        Hint  = "",
    },

    -- Debugger icons
    debugger = {
        Stopped     = { "󰁕", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint  = "",
        Conditional = "",
        Rejected    = { "", "DiagnosticError" },
        Logpoint    = ".>",
    },

    -- LSP icons
    lsp = {
        Loaded  = "",
        Loading = { "", "󰀚", "" },
    },

    -- UI icons
    ui = {
        Arrow_left      = "",
        Arrow_right     = "",
        Bookmarks       = "",
        Buffer_close    = "󰅖",
        Collapsed       = "",
        Ellipsis        = "󰇘",
        Environment     = "",
        Fold_closed     = "",
        Fold_opened     = "",
        Fold_separator  = " ",
        Macro_recording = "",
        Paste           = "󰅌",
        Refresh         = "",
        Run             = "󰑮",
        Search          = "",
        Selected        = "❯",
        Tab             = "󰓩",
        Tab_close       = "󰅙",
        Terminal        = "",
        Test            = "󰙨",
        Window          = "",
    },

    -- Kind icons
    kind = {
        Array         = "",
        Boolean       = "󰨙",
        Class         = "",
        Codeium       = "󰘦",
        Color         = "",
        Constant      = "󰏿",
        Constructor   = "",
        Enum          = "",
        Event         = "",
        Field         = "",
        File          = "󰈙",
        Folder        = "",
        Function      = "󰊕",
        Interface     = "",
        Key           = "",
        Keyword       = "",
        Namespace     = "󰦮",
        Null          = "",
        Number        = "󰎠",
        Object        = "",
        Operator      = "",
        Package       = "",
        Property      = "",
        Reference     = "",
        Snippet       = "",
        String        = "",
        Struct        = "",
        Text          = "",
        Typeparameter = "",
        Unit          = "",
        Value         = "",
        Variable      = "",
    },
}
