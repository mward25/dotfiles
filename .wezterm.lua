-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font 'Fira Code'
config.color_scheme = "Catppuccin Macchiato"

return config
