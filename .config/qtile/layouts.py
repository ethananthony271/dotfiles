from libqtile import layout
import colors

c = colors.gruvbox_dark

def init_layouts():
    layouts = [
        layout.Columns(
            border_focus_stack=["#d75f5f", "#8f3d3d"],
            border_focus = c["alt_yellow"],
            border_normal = c["green"],
            border_width = 4,
            margin = 6,
            margin_on_single = 6,
            border_on_single = c["yellow"],
        ),
        layout.Max(),
        # Try more layouts by unleashing below layouts.
        # layout.Stack(num_stacks=2),
        # layout.Bsp(),
        # layout.Matrix(),
        # layout.MonadTall(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
    ]

    return layouts
