local config = {
    autostart = true,
    cursor = "",              
    texthl = "SmoothCursor",   
    linehl = nil,              
    type = "exp",          
    fancy = {
        enable = true,        
        head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
        body = {
            { cursor = "", texthl = "SmoothCursorRed" },
            { cursor = "", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" }
    },
    flyin_effect = nil,        
    speed = 35,                
    intervals = 45,            
    priority = 10,             
    timeout = 3000,            
    threshold = 3,             
    disable_float_win = false, 
    enabled_filetypes = nil,   
    disabled_filetypes = {
        "veil",
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
    },  
}
require('smoothcursor').setup(config)
