from libqtile.lazy import lazy
from libqtile import bar, widget
from libqtile.config import Screen
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
import colors

c = colors.gruvbox_dark

def init_screens():

    widget_defaults = dict(
        font = "FiraCode Nerd Font Mono SemBd",
        fontsize = 12,
        padding = 3,
    )

    extension_defaults = widget_defaults.copy()

    screens = [
        Screen(
            top = bar.Bar(
                [
                    widget.TextBox(
                        fmt = "󰒮",
                        font = "FiraCode Nerd Font Mono Bold",
                        fontsize = 16,
                        mouse_callbacks = {"Button1": lazy.spawn("mpc prev")},
                    ),
                    widget.Mpd2(
                        status_format = "{play_status}",
                        idle_format = "{play_status}",
                        interval = 1.0,
                        play_states = {"pause": "▶", "play": "󰏤", "stop": "■"},
                        fontsize = 14,
                        padding = 0,
                    ),
                    widget.TextBox(
                        fmt = "󰒭",
                        font = "FiraCode Nerd Font Mono Bold",
                        fontsize = 16,
                        mouse_callbacks = {"Button1": lazy.spawn("mpc next")},
                        padding = 10,
                    ),
                    widget.Mpd2(
                        status_format = "{artist} - {title}",
                        idle_format = "{idle_message}", idle_message="--------------------",
                        interval = 1.0,
                        play_states = {"pause": "▶", "play": "󰏤", "stop": "■"},
                        padding = 0,

                        width = 400,
                        scroll = True,
                        scroll_delay = 3,
                    ),
                    widget.Spacer(),
                    widget.GroupBox(
                        active = c["foreground"],
                        inactive = "#808080",

                        highlight_method = "line",
                        this_current_screen_border = c["orange"],
                        highlight_color = c["background"],
                        block_highlight_text_color = c["foreground"],

                        # urgent_alert_method = "block",
                        # urgent_border = c["red"],
                        # urgent_text = c["background"],
                        
                        padding = 10,
                    ),
                    widget.Spacer(),
                    widget.Wlan(
                        use_ethernet = True,
                        interface = "wlan0",
                        ethernet_interface = 'enp1s0',
                        format = '',
                        ethernet_message = '󱎔',
                        disconnected_message = "󰖪",
                        padding = 3,
                        fontsize = 20,
                        update_interval = 10,
                    ),
                    widget.Wlan(
                        interface = "wlan0",
                        format = '{essid}',
                        use_ethernet = True,
                        ethernet_interface = 'enp1s0',
                        ethernet_message = 'Ethernet',
                        disconnected_message = "--------",
                        padding = 3,
                        update_interval = 10,
                    ),
                    widget.TextBox( fmt = "|" ),
                    widget.Volume(
                        fmt = "{}",
                        unmute_format = "",
                        mute_format = "󰝟",
                        fontsize = 20,
                        padding = 3,
                    ),
                    widget.Volume(
                        fmt = "{}",
                        mute_format = "---",
                        padding = 3,
                    ),
                    widget.TextBox( fmt = "|" ),
                    widget.Battery(
                        format = "󱊣",
                        low_foreground = c["alt_red"],
                        fontsize = 15,
                        padding = 3,
                    ),
                    widget.Battery(
                        format = "{percent:2.0%}",
                        low_foreground = c["alt_red"],
                        padding = 3,
                    ),
                    widget.TextBox( fmt = "|" ),
                    widget.TextBox(
                        fmt = "󰃠",
                        fontsize = 20,
                        padding = 3,
                    ),
                    widget.Backlight(
                        backlight_name = "amdgpu_bl1",
                        fmt = "{}",
                        step = 5,
                        padding = 3,
                    ),
                    widget.TextBox( fmt = "|" ),
                    widget.TextBox(
                        fmt = "",
                        fontsize = 20,
                        padding = 3,
                    ),
                    widget.Clock(
                        format = "%H:%M",
                        padding = 3,
                    ),
                    widget.TextBox( fmt = "|" ),
                    widget.TextBox(
                        fmt = "󰸘",
                        fontsize = 18,
                        padding = 3,
                    ),
                    widget.Clock(
                        format = "%m-%d",
                        padding = 3,
                    ),
                    widget.Spacer( length = 7 ),
                ],
                32,
                background = c["bar"],
                border_color = c["bar"],
                border_width = 0,
                # margin = [5, 5, 0, 5],
                opacity = 1,
                reserve = True,
            ),
            wallpaper = "~/.config/qtile/assets/Wallpaper/grove.jpg",
            wallpaper_mode = "stretch",
        ),
    ]

    return screens
