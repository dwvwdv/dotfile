-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- set style
config.color_scheme = 'nord'
config.font = wezterm.font 'AnonymicePro Nerd Font Mono'
config.initial_rows = 30
config.initial_cols = 120

-- disable TOP information
config.enable_tab_bar = false
config.window_decorations = 'RESIZE'

-- set shell
config.default_prog = { 'nu' }

-- and finally, return the configuration to wezterm
return config
