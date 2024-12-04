-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

lvim.colorscheme="kanagawa-wave"
lvim.plugins = {
  {
    'IogaMaster/neocord',
    event = "VeryLazy"
  },
  { "rebelot/kanagawa.nvim" },
}

vim.opt.relativenumber = true
vim.opt.tabstop = 2
-- lvim.transparent_window = true

-- Key mappings for tab navigation
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Map `gn` to go to the next tab
keymap("n", "nn", ":bnext<cr>", opts)

-- Map `gb` to go to the previous tab
keymap("n", "nb", ":bprevious<cr>", opts)

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}

require("neocord").setup({
    -- General options
    logo                = "auto",                     -- "auto" or url
    logo_tooltip        = nil,                        -- nil or string
    main_image          = "language",                 -- "language" or "logo"
    client_id           = "1157438221865717891",      -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer
    global_timer        = false,                      -- if set true, timer won't update when any event are triggered

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    terminal_text       = "Using Terminal",           -- Format string rendered when in terminal mode.
})

require("kanagawa").setup({
  compile = true,          -- Enable compilation for faster startup
  undercurl = true,        -- Enable undercurls
  transparent = false,     -- Disable background color for transparency
  dimInactive = false,     -- Do not dim inactive windows
  terminalColors = true,   -- Enable terminal colors
  colors = {
    palette = {},          -- Modify palette colors here
    theme = {
      wave = {},           -- Customize the wave theme
      dragon = {},         -- Customize the dragon theme
      lotus = {},          -- Customize the lotus theme
    },
  },
  overrides = function(colors)
    return {
      -- Example customization for floating windows
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
    }
  end,
  theme = "wave",          -- Set the default theme
  background = {
    dark = "dragon",       -- Use dragon for dark background
    light = "lotus",       -- Use lotus for light background
  },
})
