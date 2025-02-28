-- local Config = require("config")
--
-- require("events.right-status").setup()
-- require("events.tab-title").setup()
-- require("events.new-tab-button").setup()
--
-- return Config:init()
--   :append(require("config.appearance"))
--   :append(require("config.bindings"))
--   :append(require("config.domains"))
--   :append(require("config.fonts"))
--   :append(require("config.general"))
--   :append(require("config.launch")).options
--
--

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
-- config.debug_key_events = true


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
-- Enable persistent session using named pipe on Windows
config.unix_domains = {
  {
    name = "last",
  },
}
-- Automatically connect to the persistent domain at startup
-- config.default_gui_startup_args = { "connect", "last" }
--
-- wezterm.on("gui-startup", function(cmd)
--   local mux = wezterm.mux
--   
--   -- 检查 "last" domain 是否有活动会话
--   if mux:get_domain("last"):has_any_panes() then
--     -- 如果有活动会话，创建新窗口
--     mux:spawn_window({})
--   else
--     -- 如果没有活动会话，连接到 last domain
--     mux:spawn_window({
--       domain = { DomainName = "last" },
--     })
--   end
-- end)

-- set keybind
local act = wezterm.action
local mod = {}
mod.SUPER = "ALT" -- to not conflict with Windows key shortcuts
mod.SUPER_REV = "ALT|CTRL"

local keys = {
  -- misc/useful --
  -- { key = "F1", mods = "NONE", action = "ActivateCopyMode" },
  -- { key = "F2", mods = "NONE", action = act.ActivateCommandPalette },
  -- { key = "F3", mods = "NONE", action = act.ShowLauncher },
  -- { key = "F4", mods = "NONE", action = act.ShowTabNavigator },
  -- { key = "F11", mods = "NONE", action = act.ToggleFullScreen },
  -- { key = "F12", mods = "NONE", action = act.ShowDebugOverlay },
  -- { key = "f", mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = "" }) },
  --
  -- -- copy/paste --
  -- { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
  -- { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
  --
  -- -- tabs --
  -- -- tabs: spawn+close
  -- { key = "t", mods = mod.SUPER, action = act.SpawnTab("DefaultDomain") },
  -- -- { key = "t", mods = mod.SUPER_REV, action = act.SpawnTab({ DomainName = "WSL:Ubuntu" }) },
  -- { key = "w", mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },
  --
  -- -- tabs: navigation
  -- { key = "[", mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
  -- { key = "]", mods = mod.SUPER, action = act.ActivateTabRelative(1) },
  -- { key = "[", mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
  -- { key = "]", mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },
  --
  -- window --
  -- spawn windows
  -- { key = "n", mods = mod.SUPER, action = act.SpawnWindow },

  -- panes --
  -- panes: split panes
  {
    key = [[/]],
    mods = mod.SUPER_REV,
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = [[\]],
    mods = mod.SUPER_REV,
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = [[-]],
    mods = mod.SUPER_REV,
    action = act.CloseCurrentPane({ confirm = true }),
  },

  -- panes: zoom+close pane
  { key = "z", mods = mod.SUPER_REV, action = act.TogglePaneZoomState },
  -- { key = "w", mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

  -- panes: navigation
  -- { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
  { key = "o", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Up") }, -- powertoys mapping ctrl+alt+k -> ctrl+alt+o
  { key = "j", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Down") },
  { key = "h", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Right") },

  -- panes: resize
  { key = "UpArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({ "Up", 1 }) },
  { key = "DownArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({ "Down", 1 }) },
  { key = "LeftArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({ "Left", 1 }) },
  { key = "RightArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({ "Right", 1 }) },

  -- fonts --
  -- fonts: resize
  -- { key = "UpArrow", mods = mod.SUPER, action = act.IncreaseFontSize },
  -- { key = "DownArrow", mods = mod.SUPER, action = act.DecreaseFontSize },
  -- { key = "r", mods = mod.SUPER, action = act.ResetFontSize },

  -- key-tables --
  -- resizes fonts
  -- {
  --   key = "f",
  --   mods = "LEADER",
  --   action = act.ActivateKeyTable({
  --     name = "resize_font",
  --     one_shot = false,
  --     timemout_miliseconds = 1000,
  --   }),
  -- },
  -- -- resize panes
  -- {
  --   key = "p",
  --   mods = "LEADER",
  --   action = act.ActivateKeyTable({
  --     name = "resize_pane",
  --     one_shot = false,
  --     timemout_miliseconds = 1000,
  --   }),
  -- },
  -- -- rename tab bar
  -- {
  --   key = "R",
  --   mods = "CTRL|SHIFT",
  --   action = act.PromptInputLine({
  --     description = "Enter new name for tab",
  --     action = wezterm.action_callback(function(window, pane, line)
  --       -- line will be `nil` if they hit escape without entering anything
  --       -- An empty string if they just hit enter
  --       -- Or the actual line of text they wrote
  --       if line then
  --         window:active_tab():set_title(line)
  --       end
  --     end),
  --   }),
  -- },
}
config.keys = keys

-- and finally, return the configuration to wezterm
return config
