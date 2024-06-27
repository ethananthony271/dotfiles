"""
Copyright (c) 2010 Aldo Cortesi
Copyright (c) 2010, 2014 dequis
Copyright (c) 2012 Randall Ma
Copyright (c) 2012-2014 Tycho Andersen
Copyright (c) 2012 Craig Barnes
Copyright (c) 2013 horsik
Copyright (c) 2013 Tao Sauvage

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

import keys, screens, colors, mouse, layouts, floating_layout
import os
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "kitty"
browser = "firefox"
fileManager = "nautilus"
musicPlayer = "kitty"
messager = "kitty"
emailClient = "kitty"

keys = keys.init_keys()

layouts = layouts.init_layouts()

floating_layout = floating_layout.init_floating_layout()

mouse = mouse.init_mouse()

c = colors.gruvbox_dark
widget_defaults = dict(
    font = "FiraCode Nerd Font Mono SemBd",
    fontsize = 12,
    padding = 10,
    foreground = c["alt_foreground"],
)
screens = screens.init_screens()

follow_mouse_focus = False
bring_front_click = True
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "urgent"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"
