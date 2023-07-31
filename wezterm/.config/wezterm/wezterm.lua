local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'rose-pine-moon'
config.font = wezterm.font {
  family = 'Fira Code Nerd Font',
  harfbuzz_features = { 'zero' },
}
config.font_size = 15
config.font_rules = {
    {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font {
            family = 'VictorMono',
            weight = 'Bold',
            style = 'Italic',
        },
    },
    {
        italic = true,
        intensity = 'Half',
        font = wezterm.font {
            family = 'VictorMono',
            weight = 'DemiBold',
            style = 'Italic',
        },
    },
    {
        italic = true,
        intensity = 'Normal',
        font = wezterm.font {
            family = 'VictorMono',
            style = 'Italic',
        },
    },
}

return config
