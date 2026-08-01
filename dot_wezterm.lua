-- wezterm config mirroring kitty.conf settings
-- This file lives in chezmoi source as dot_wezterm.lua

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ---------------------------------------------------------------------------
-- Font
-- ---------------------------------------------------------------------------
config.font = wezterm.font("Iosevka")
config.font_size = 14.0

-- ---------------------------------------------------------------------------
-- Color scheme
-- ---------------------------------------------------------------------------
-- Catppuccin Macchiato palette taken from current-theme.conf
config.color_scheme = "Catppuccin Macchiato"

-- Override with the exact Kitty theme colors
config.colors = {
	foreground = "#CAD3F5",
	background = "#24273A",
	selection_fg = "#24273A",
	selection_bg = "#F4DBD6",
	cursor_bg = "#F4DBD6",
	cursor_fg = "#24273A",
	cursor_border = "#F4DBD6",
	visual_bell = "#EED49F",
	ansi = {
		"#494D64", -- black
		"#ED8796", -- red
		"#A6DA95", -- green
		"#EED49F", -- yellow
		"#8AADF4", -- blue
		"#F5BDE6", -- magenta
		"#8BD5CA", -- cyan
		"#B8C0E0", -- white
	},
	brights = {
		"#5B6078", -- bright black
		"#ED8796", -- bright red
		"#A6DA95", -- bright green
		"#EED49F", -- bright yellow
		"#8AADF4", -- bright blue
		"#F5BDE6", -- bright magenta
		"#8BD5CA", -- bright cyan
		"#A5ADCB", -- bright white
	},
	tab_bar = {
		background = "#181926",
		active_tab = {
			bg_color = "#C6A0F6",
			fg_color = "#181926",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#1E2030",
			fg_color = "#CAD3F5",
		},
		inactive_tab_hover = {
			bg_color = "#363A4F",
			fg_color = "#CAD3F5",
		},
		new_tab = {
			bg_color = "#1E2030",
			fg_color = "#CAD3F5",
		},
		new_tab_hover = {
			bg_color = "#363A4F",
			fg_color = "#CAD3F5",
		},
	},
}

-- ---------------------------------------------------------------------------
-- Window / cursor / bell
-- ---------------------------------------------------------------------------
config.enable_wayland = true
config.window_decorations = "RESIZE"
config.hide_mouse_cursor_when_typing = true
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_duration_ms = 0,
	fade_out_duration_ms = 0,
}

-- Cursor: kitty default is block, so keep wezterm's default SteadyBlock.
-- Beam thickness from kitty is 1.5pt; wezterm has cursor_thickness.
config.default_cursor_style = "SteadyBlock"
config.cursor_thickness = "1.5pt"

-- ---------------------------------------------------------------------------
-- Scrollback
-- ---------------------------------------------------------------------------
config.scrollback_lines = 8096

-- ---------------------------------------------------------------------------
-- Tab bar
-- ---------------------------------------------------------------------------
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.switch_to_last_active_tab_when_closing_tab = true

-- Powerline-style separators (matches kitty tab_bar_style powerline, angled)
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- Draw a tab title with powerline edges. Used by format-tab-title below.
local function format_tab_title(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#181926"
	local background = "#1E2030"
	local foreground = "#CAD3F5"

	if tab.is_active then
		background = "#C6A0F6"
		foreground = "#181926"
	elseif hover then
		background = "#363A4F"
		foreground = "#CAD3F5"
	end

	local edge_foreground = background

	local title = tab.tab_title
	if not title or #title == 0 then
		title = tab.active_pane.title
	end

	-- Leave room for the edges and optional index prefix.
	title = wezterm.truncate_right(title, max_width - 4)

	local prefix = ""
	if config.show_tab_index_in_tab_bar then
		local index = tab.tab_index + 1
		prefix = tostring(index) .. ":"
	end

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. prefix .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end

wezterm.on("format-tab-title", format_tab_title)

-- ---------------------------------------------------------------------------
-- Selection / hyperlinks
-- ---------------------------------------------------------------------------
config.selection_word_boundary = " \t\n{}[]()\"\'`"
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- ---------------------------------------------------------------------------
-- Keyboard: emulate kitty_mod = alt
-- ---------------------------------------------------------------------------
-- kitty_mod is set to "alt" in kitty.conf, so most custom mappings use alt.
-- WezTerm needs ALT equivalents for the custom actions. The base system
-- mappings (copy/paste, font size, etc.) from kitty default to ctrl+shift are
-- left to wezterm defaults unless kitty overrides them.

config.keys = {
	-- Pane focus (kitty: alt+h/j/k/l)
	{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },

	-- New OS window with current cwd (kitty: alt+n)
	{ key = "n", mods = "ALT", action = act.SpawnWindow },

	-- New tab with current cwd (kitty: alt+t)
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },

	-- Next/previous tab (kitty: alt+tab / alt+shift+tab)
	{ key = "Tab", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "ALT|SHIFT", action = act.ActivateTabRelative(-1) },

	-- Pass ctrl+tab through to terminal programs (neovim, etc.)
	{ key = "Tab", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },

	-- Scrollback in pager (kitty: alt+s)
	-- Uses the same pager_mode.sh helper from kitty.
	{
		key = "s",
		mods = "ALT",
		action = act.SpawnCommandInNewTab {
			args = { "bash", os.getenv("HOME") .. "/.config/kitty/pager_mode.sh" },
		},
	},

	-- Resize overlay (kitty: alt+r)
	{
		key = "r",
		mods = "ALT",
		action = act.SpawnCommandInNewTab {
			args = { "bash", os.getenv("HOME") .. "/.config/kitty/resize_mode.sh", "--amount=2" },
		},
	},

	-- Layout cycling (kitty: alt+] / alt+[)
	-- WezTerm doesn't have named kitty layouts; "next layout" here just rotates
	-- panes or zooms. Mapped to TogglePaneZoomState and RotatePanes.
	{ key = "]", mods = "ALT", action = act.RotatePanes("Clockwise") },
	{ key = "[", mods = "ALT", action = act.RotatePanes("CounterClockwise") },

	-- Scroll line up/down (kitty: alt+shift+k / alt+shift+j)
	{ key = "K", mods = "ALT|SHIFT", action = act.ScrollByLine(-1) },
	{ key = "J", mods = "ALT|SHIFT", action = act.ScrollByLine(1) },

	-- Font size (kitty defaults with ctrl+shift)
	{ key = "=", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL|SHIFT", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL|SHIFT", action = act.ResetFontSize },

	-- Fullscreen (kitty: alt+f11)
	{ key = "F11", mods = "NONE", action = act.ToggleFullScreen },
	-- WezTerm has no built-in ToggleMaximized; use a callback instead.
	{
		key = "F10",
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			window:maximize()
		end),
	},

	-- Reload config
	{ key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
}

-- ---------------------------------------------------------------------------
-- Leader-style "alt+enter" pane management (kitty chords)
-- ---------------------------------------------------------------------------
-- kitty uses a chord sequence alt+enter>h/j/k/l. WezTerm can approximate this
-- with a key table activated by ALT+ENTER.

config.key_tables = {
	pane_control = {
		-- Splits that match kitty's launch --location=vsplit/hsplit semantics
		-- h/l: vertical split (left/right); k/j: horizontal split (top/bottom)
		{
			key = "l",
			action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
		},
		{
			key = "h",
			action = act.Multiple {
				act.SplitHorizontal { domain = "CurrentPaneDomain" },
				act.ActivatePaneDirection("Left"),
			},
		},
		{
			key = "j",
			action = act.SplitVertical { domain = "CurrentPaneDomain" },
		},
		{
			key = "k",
			action = act.Multiple {
				act.SplitVertical { domain = "CurrentPaneDomain" },
				act.ActivatePaneDirection("Up"),
			},
		},
		-- Rotate layout (kitty: alt+enter>r)
		{ key = "r", action = act.RotatePanes("Clockwise") },
		{ key = "]", action = act.RotatePanes("Clockwise") },
	},
}

-- Activate pane_control key table with ALT+ENTER.
-- one_shot = true makes the table automatically exit after the next key.
-- until_unknown = true means any key not in the table will also exit it.
table.insert(config.keys, {
	key = "Enter",
	mods = "ALT",
	action = act.ActivateKeyTable {
		name = "pane_control",
		one_shot = true,
		until_unknown = true,
	},
})

-- ---------------------------------------------------------------------------
-- Mouse bindings (basic kitty-compatible selection)
-- ---------------------------------------------------------------------------
config.mouse_bindings = {
	-- Click link under mouse
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL|SHIFT",
		action = act.OpenLinkAtMouseCursor,
	},
	-- Middle click paste from primary selection
	{
		event = { Up = { streak = 1, button = "Middle" } },
		mods = "NONE",
		action = act.PasteFrom("PrimarySelection"),
	},
}

return config
