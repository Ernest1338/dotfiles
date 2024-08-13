local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config.color_scheme = 'Ayu Mirage (Gogh)'
config.enable_tab_bar = false
config.font = wezterm.font 'Hack'
config.font_size = 11
config.window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
}

return config
