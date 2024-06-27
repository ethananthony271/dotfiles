#! /bin/bash

yt-dlp --config-location ~/.config/yt-dlp/albumconfig.conf $1

beet import ~/Music/musicStagingGround
