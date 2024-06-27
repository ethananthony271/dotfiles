from libqtile import layout
import colors
from libqtile.config import Match

c = colors.gruvbox_dark

def init_floating_layout():
    floating_layout = layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
        ],
        border_width = 4,
        border_focus = c["magenta"],
        border_normal = c["green"],
    )

    return floating_layout
