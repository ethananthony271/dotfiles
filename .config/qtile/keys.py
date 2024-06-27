# https://docs.qtile.org/en/latest/manual/config/lazy.html

import os
from libqtile.config import Key, KeyChord, Click, Drag, Group
from libqtile.lazy import lazy

mod = "mod4"

terminal = "kitty"
browser = "librewolf"
fileManager = "kitty -e yazi"
musicPlayer = "kitty -e ncmpcpp"
messager = "kitty"
emailClient = "kitty -e neomutt"

def init_keys():
    keys = [
        # Manage QTile
        Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

        # Switch focus between windows
        Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

        # Move windows throughout workspace layour
        Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

        # Resize windows
        Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
        Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
        Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
        Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

        # Toggle stacking windows
        Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

        # Launch programs
        Key([mod], "a", lazy.spawn(terminal), desc="Launch terminal"),
        Key([mod], "s", lazy.spawn(browser), desc="Launch browser"),
        Key([mod], "d", lazy.spawn(fileManager), desc="Launch file manager"),
        Key([mod], "z", lazy.spawn(musicPlayer), desc="Launch music player"),
        Key([mod], "x", lazy.spawn(messager), desc="Launch messager"),
        Key([mod], "c", lazy.spawn(emailClient), desc="Launch email client"),

        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

        # Manage windows
        Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod], "w", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
        Key([mod], "e", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
        Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
        Key([mod], "Tab", lazy.group.next_window(), desc="Focus next window"),

        # Brightness controls
        Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +2%"), desc = "Brightness up"),
        Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 2-%"), desc = "Brightness down"),

        # Media controls
        Key([], "XF86AudioMute", lazy.spawn("amixer -q sset Master toggle"), desc="Toggle mute"),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q sset Master 5%+"), desc="Volume up"),
        Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q sset Master 5%-"), desc="Volume down"),
        Key([], "F1", lazy.spawn("mpc prev"), desc="Next song"),
        Key([], "F2", lazy.spawn("mpc toggle"), desc="Play/pause"),
        Key([], "F3", lazy.spawn("mpc stop"), desc="Stop playback"),
        Key([], "F4", lazy.spawn("mpc next"), desc="Previous song"),

        # Toggle Touchpad
        # TODO # Key([], "XF86TouchpadToggle", lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/toggleTouchpad.sh")), desc="Toggle touchpad"),

        # Print screen
        Key([], "Print", lazy.spawn("flameshot gui"), desc="Volume down"),

        # Launch Rofi
        Key([mod], "space", lazy.spawn("rofi -modi drun,window,ssh,calc -show drun"), desc="Launch Rofi"),

        # Toggle light/dark mode
        Key([mod], "grave", lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/toggleTheme.sh"), shell=True), desc="Toggle light/dark mode"),

        # Various Rofi menus
        Key([mod], "Delete", lazy.spawn("rofi -show p -modi p:rofi-power-menu.sh"), desc="Rofi power menu"),
        Key([mod], "BackSpace", lazy.spawn("rofi-wifi-menu.sh"), desc="Rofi power menu"),

        # Fancy workspace management
        # TODO: Create a function to focus urgent workspace
    ]

    # Manage workspaces
    groups = [Group(i) for i in "123456789"]
    for i in groups:
        keys.extend([
            Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
        ]
    )

    return keys
