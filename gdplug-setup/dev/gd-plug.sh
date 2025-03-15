
# Activates (sets) alias expansion
shopt -s expand_aliases

# Executes the .bashrc, which defines the godot alias, on my setup
source ~/.bashrc

# Points to the script that runs the gd-plug
PLUG_SCRIPT=plug.gd

# If init is passed, uses the addon plug.gd to init the user one
if [ "$1" == "init" ]; then
  PLUG_SCRIPT=addons/gd-plug/plug.gd
fi

# Executes gd-plug with the params passed, using the godot set in the aliases
godot --no-header --headless --script "$PLUG_SCRIPT" "$@"
