#!/bin/bash

DOTFILES_DIR="$(dirname "$0")"

echo "🔵 Restoring dotfiles..."

# Caelestia user config
if [ -d "$DOTFILES_DIR/caelestia-config" ]; then
    echo "📂 Restoring Caelestia user config..."
    mkdir -p ~/.config/caelestia
    cp -r "$DOTFILES_DIR/caelestia-config/." ~/.config/caelestia/
fi

# Caelestia source
if [ -d "$DOTFILES_DIR/caelestia-source" ]; then
    echo "📂 Restoring Caelestia source..."
    mkdir -p ~/.local/share/caelestia
    cp -r "$DOTFILES_DIR/caelestia-source/." ~/.local/share/caelestia/
fi

# Quickshell
if [ -d "$DOTFILES_DIR/quickshell" ]; then
    echo "📂 Restoring Quickshell..."
    mkdir -p ~/.config/quickshell
    cp -r "$DOTFILES_DIR/quickshell/." ~/.config/quickshell/
fi

# Config tambahan
for dir in cava fuzzel gtk-3.0 gtk-4.0 autostart spicetify; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        mkdir -p ~/.config/$dir
        cp -r "$DOTFILES_DIR/$dir/." ~/.config/$dir/
        echo "  ✓ $dir"
    fi
done

echo "✅ Restore selesai! Silakan restart Hyprland."