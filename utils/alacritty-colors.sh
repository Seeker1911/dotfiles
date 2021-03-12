REPO=https://github.com/eendroroy/alacritty-theme.git
DEST="$XDG_CONFIG_HOME/alacritty/eendroroy-colorschemes"
# Get colorschemes
git clone $REPO $DEST
# Create symlink at default colors location (optional)
ln -s "$DEST/themes" "$XDG_CONFIG_HOME/alacritty/colors"
