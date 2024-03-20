--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "12px monospace"
theme.fg   = "#2a283e"
theme.bg   = "#e0def4"

-- General colours
theme.success_fg = "#92b158"
theme.loaded_fg  = "#33AADD"
theme.error_fg = "#e0def4"
theme.error_bg = "#eb6f92"

-- Warning colours
theme.warning_fg = "#eb6f92"
theme.warning_bg = "#e0def4"

-- Notification colours
theme.notif_fg = "#444"
theme.notif_bg = "#e0def4"

-- Menu colours
theme.menu_fg                   = "#f6c177"
theme.menu_bg                   = "#26233a"
theme.menu_selected_fg          = "#e0def4"
theme.menu_selected_bg          = "#403d52"
theme.menu_title_bg             = "#26233a"
theme.menu_primary_title_fg     = "#eb6f92"
theme.menu_secondary_title_fg   = "#c4a7e7"

theme.menu_disabled_fg = "#999"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg = theme.menu_fg
theme.menu_enabled_bg = theme.menu_bg
theme.menu_active_fg = "#8ca000"
theme.menu_active_bg = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg      = '#f6c177'
theme.proxy_active_menu_bg      = '#e0def4'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#e0def4'

-- Statusbar specific
theme.sbar_fg         = "#9ccfd8"
theme.sbar_bg         = "#21202e"

-- Downloadbar specific
theme.dbar_fg         = "#e0def4"
theme.dbar_bg         = "#f6c177"
theme.dbar_error_fg   = "#eb6f92"

-- Input bar specific
theme.ibar_bg           = "#2a283e"
theme.ibar_fg           = "#e0def4"

-- Tab label
theme.tab_fg            = "#908caa"
theme.tab_bg            = "#393552"
theme.tab_hover_bg      = "#2a273f"
theme.tab_ntheme        = "#ddd"
theme.selected_fg       = "#e0def4"
theme.selected_bg       = "#232136"
theme.selected_ntheme   = "#ddd"
theme.loading_fg        = "#33AADD"
theme.loading_bg        = "#f6c177"

theme.selected_private_tab_bg = "#3d295b"
theme.private_tab_bg    = "#22254a"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#92b158"
theme.notrust_fg        = "#eb6f92"

-- Follow mode hints
theme.hint_font = "10px monospace, courier, sans-serif"
theme.hint_fg = "#26233a"
theme.hint_bg = "#9ccfd8"
theme.hint_border = "1px dashed #f6c177"
theme.hint_opacity = "0.3"
theme.hint_overlay_bg = "rgba(255,255,153,0.3)"
theme.hint_overlay_border = "1px dotted #f6c177"
theme.hint_overlay_selected_bg = "rgba(0,255,0,0.3)"
theme.hint_overlay_selected_border = theme.hint_overlay_border

-- General colour pairings
theme.ok = { fg = "#e0def4", bg = "#1f1d2e" }
theme.warn = { fg = "#ebbcba", bg = "#1f1d2e" }
theme.error = { fg = "#eb6f92", bg = "#1f1d2e" }

-- Gopher page style (override defaults)
theme.gopher_light = { bg = "#E8E8E8", fg = "#17181C", link = "#03678D" }
theme.gopher_dark  = { bg = "#17181C", fg = "#E8E8E8", link = "#f90" }

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
