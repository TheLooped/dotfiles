-- Keymaps
local map = require("util.cmds").map

vim.g.mapleader = " "

--- Create a new file
local new_file = function()
    return function()
        local fname = vim.fn.input "New file name: "
        if fname == "" then
            vim.notify("No file name provided", vim.log.levels.WARN)
            return
        end

        vim.cmd "enew"
        vim.api.nvim_buf_set_name(0, fname)
        vim.notify("Created new file: " .. fname, vim.log.levels.INFO)
    end
end

--- Save the current file
local save_file = function()
    return function()
        local fullname = vim.fn.expand "%:p"
        local fname = vim.fn.expand "%:t"

        if fname == "" then
            if
                vim.fn.confirm(
                    "No file name - save buffer as new file?",
                    "&Yes\n&No"
                ) ~= 1
            then
                vim.notify("Save cancelled", vim.log.levels.WARN)
                return
            end

            local new_fname = vim.fn.input "New file name: "
            if new_fname == "" then
                vim.notify(
                    "Save cancelled - no file name provided",
                    vim.log.levels.WARN
                )
                return
            end

            fullname = vim.fn.expand "%:p:h" .. "/" .. new_fname
            fname = new_fname
        end

        local success, err = pcall(vim.cmd, "write " .. fullname)
        if success then
            vim.notify("Successfully saved " .. fname, vim.log.levels.INFO)
        else
            vim.notify(
                "Failed to save " .. fname .. ": " .. err,
                vim.log.levels.ERROR
            )
        end
    end
end

--- Make the current file executable
local make_exe = function()
    return function()
        local current_file = vim.fn.expand "%:t"

        -- Check if file is already executable
        if vim.fn.executable(current_file) == 1 then
            vim.notify("File is already executable", vim.log.levels.WARN)
            return
        end

        -- Check file extension
        local is_bash = vim.fn.match(current_file, ".sh$") > 0

        -- Confirm with user
        local confirm_msg = is_bash and "Confirm making .sh executable"
            or "Confirm making non-script executable"
        if vim.fn.confirm(confirm_msg, "&Yes\n&No") ~= 1 then
            vim.notify("Cancelled", vim.log.levels.INFO)
            return
        end

        -- Make executable
        local ok, result = pcall(vim.fn.system, { "chmod", "+x", current_file })
        if ok then
            vim.notify("File is now executable", vim.log.levels.INFO)
        else
            vim.notify(
                "Failed to make executable: " .. result,
                vim.log.levels.ERROR
            )
        end
    end
end

map("n", "<leader>fn", new_file(), { desc = "New File" })

map("n", "<leader>fs", save_file(), { desc = "Saves File" })

map(
    "n",
    "<leader>fx",
    make_exe(),
    { desc = "Makes current file an executable" }
)

---#### Code Navigation ####---

--- Better Movement ---
map(
    "n",
    "j",
    "v:count == 0 ? 'gj' : 'j' ",
    { expr = true, silent = true, desc = "Better Down" }
)
map(
    "n",
    "k",
    "v:count == 0 ? 'gk' : 'k' ",
    { expr = true, silent = true, desc = "Better Up" }
)

map("n", "<C-d>", "<C-d>zz", { desc = "Better Downwards navigation" })
map("n", "<C-u>", "<C-u>zz", { desc = "Better Upwards navigation" })

---#### Windows Management ####---

-- Better Window Movement
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window Creation & Deletion
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split Horizontal" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split Vertical" })
map("n", "<leader>wd", "<C-w>q", { desc = "Close Window" })

-- Window Resizing
map("n", "<A-h>", ":vertical resize -2<CR>", { desc = "Decrease split width" })
map("n", "<A-j>", ":resize -2<CR>", { desc = "Decrease split height" })
map("n", "<A-l>", ":vertical resize +2<CR>", { desc = "Increase split width" })
map("n", "<A-k>", ":resize +2<CR>", { desc = "Increase split height" })

---#### Code Manipulation && Editing ####---

-- Normal Line Movement
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })

-- Visual Line Movement
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Indentation
map("v", ">", ">gv", { desc = "Better Indent" })
map("v", "<", "<gv", { desc = "Better Dedent" })
map("v", "<Tab>", ">gv", { desc = "Better Indent" })
map("v", "<S-Tab>", "<gv", { desc = "Better Dedent" })

-- Copying & Pasting

map({ "n", "v" }, "p", "p", { desc = "Regular paste" })
map({ "n", "v" }, "y", "y", { desc = "Regular copy" })

map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })

map("n", "<leader>Y", '"+yy', { desc = "Copy line to system clipboard" })

-- Search
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })
map(
    "n",
    "<leader>h",
    "<cmd>nohlsearch<cr>",
    { desc = "Clear search highlights" }
)

---#### Quality Of Life ####---
map("i", "<leader>j", "<Esc>", { desc = "Exit Insert" })
map("n", "J", "mzJ`z", { desc = "Better line joining" })

--### Plugins

-- Plugin Manager
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

--- Git Related

--- GitSigns
map("n", "g]", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Git hunk" })
map("n", "g[", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous Git hunk" })
map(
    "n",
    "<leader>gl",
    "<cmd>Gitsigns blame_line<cr>",
    { desc = "View Git blame" }
)
map(
    "n",
    "<leader>gL",
    "<cmd>Gitsigns blame_line { full = true }<cr>",
    { desc = "View full Git blame" }
)
map(
    "n",
    "<leader>gp",
    "<cmd>Gitsigns preview_hunk<cr>",
    { desc = "Preview Git hunk" }
)
map(
    "n",
    "<leader>gh",
    "<cmd>Gitsigns reset_hunk<cr>",
    { desc = "Reset Git hunk" }
)
map(
    "n",
    "<leader>gr",
    "<cmd>Gitsigns reset_buffer<cr>",
    { desc = "Reset Git buffer" }
)
map(
    "n",
    "<leader>gs",
    "<cmd>Gitsigns stage_hunk<cr>",
    { desc = "Stage Git hunk" }
)
map(
    "n",
    "<leader>gS",
    "<cmd>Gitsigns stage_buffer<cr>",
    { desc = "Stage Git buffer" }
)
map(
    "n",
    "<leader>gu",
    "<cmd>Gitsigns undo_stage_hunk<cr>",
    { desc = "Unstage Git hunk" }
)
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "View Git diff" })
--- LSP Related

-- LspUI
map("n", "<leader>lh", "<cmd>LspUI hover<cr>", { desc = "LspUI hover" })
map("n", "<leader>ln", "<cmd>LspUI rename<cr>", { desc = "LspUI Rename" })
map(
    "n",
    "<leader>ld",
    "<cmd>LspUI diagnostic<cr>",
    { desc = "LspUI Diagnostic" }
)
map(
    "n",
    "<leader>la",
    "<cmd>LspUI code_action<cr>",
    { desc = "LspUI Code_Action" }
)
map("n", "<leader>lr", "<cmd>LspUI reference<cr>", { desc = "LspUI Reference" })
--map("n", "<leader>li", "<cmd>LspUI<cr>", { desc = "LspUI" })
map(
    "n",
    "<leader>li",
    "<cmd>LspUI implementation<cr>",
    { desc = "LspUI Implementation" }
)
map(
    "n",
    "<leader>lt",
    "<cmd>LspUI type_definition<cr>",
    { desc = "LspUI Type Definition" }
)
map(
    "n",
    "<leader>lp",
    "<cmd>LspUI declaration<cr>",
    { desc = "LspUI Declaration" }
)
map(
    "n",
    "<leader>lf",
    "<cmd>LspUI definition<cr>",
    { desc = "LspUI Definition" }
)

--- Telescope Related

map(
    "n",
    "<leader>ff",
    "<cmd>Telescope find_files<cr>",
    { desc = "Find Files Global" }
)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map(
    "n",
    "<leader>fz",
    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    { desc = "Fuzzy Find in Buffer" }
)
-- Editor Related

-- Search And Replace
map("n", "<leader>mt", "<cmd>MurenToggle<cr>", { desc = "Toggles Muren" })
map(
    "n",
    "<leader>mu",
    "<cmd>MurenToggle<cr>",
    { desc = "Unique Muren Instance" }
)
map(
    "n",
    "<leader>mf",
    "<cmd>MurenFresh<cr>",
    { desc = "Fresh New Muren Instance" }
)

-- Mini files
map(
    "n",
    "<leader>fe",
    "<cmd>lua MiniFiles.open()<cr>",
    { desc = "Open Mini Files" }
)

-- Grapple Related
map(
    "n",
    "<leader>gt",
    function() require("grapple").toggle() end,
    { desc = "Grapple Toggle tag" }
)
map(
    "n",
    "<leader>gpt",
    function() require("grapple").toggle_tags() end,
    { desc = "Grapple Popup tags" }
)
map(
    "n",
    "<leader>gps",
    function() require("grapple").toggle_scopes() end,
    { desc = "Grapple Popup scopes" }
)
map(
    "n",
    "<leader>t[",
    function() require("grapple").cycle_tags("prev") end,
    { desc = "Grapple cycle backward" }
)
map(
    "n",
    "<leader>t]",
    function() require("grapple").cycle_tags("next") end,
    { desc = "Grapple cycle forward" }
)

map("n", "<leader>gS", function()
    local tagName = vim.fn.input { prompt = "Tag Name: " }
    require("grapple").select({ name = tagName })
end, { desc = "Select Tag by name" })

map("n", "<leader>gT", function()
    local tagName = vim.fn.input { prompt = "Tag Name: " }
    require("grapple").tag({ name = tagName })
end, { desc = "Grapple Tag with key" })

-- Themery
map("n", "<leader>th", "<cmd>Themery<cr>", { desc = "Themery" })
