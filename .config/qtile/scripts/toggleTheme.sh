# Kitty Colorscheme Reload
if grep -q kanagawa-lotus.conf ~/.config/kitty/kitty.conf; then
  sed -i 's/kanagawa-lotus.conf/kanagawa-wave.conf/g' ~/.config/kitty/kitty.conf
else
  sed -i 's/kanagawa-wave.conf/kanagawa-lotus.conf/g' ~/.config/kitty/kitty.conf
fi

# TODO: Reload all kitty sessions
kill -USR1 $KITTY_PID

# Neovim Colorscheme Reload
if grep -q "kanagawa-lotus" ~/.config/nvim/lua/plugins/kanagawa.lua; then
  sed -i 's/"kanagawa-lotus"/"kanagawa-wave"/g' ~/.config/nvim/lua/plugins/kanagawa.lua
else
  sed -i 's/"kanagawa-wave"/"kanagawa-lotus"/g' ~/.config/nvim/lua/plugins/kanagawa.lua
fi

# TODO: Get Nvim to reload in place without restarting

# for path in $(nvr --nostart --serverlist)
# do
#   nvr --nostart --servername $path -cc 'so ~/.config/nvim/init.lua'
# done
