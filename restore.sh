#!/bin/bash

DOTFILES_DIR="$(dirname "$0")"
THEMES_DIR="$DOTFILES_DIR/themes"

# Tampilkan tema yang tersedia
echo "🎨 Tema yang tersedia:"
ls "$THEMES_DIR"

echo ""
read -p "→ Pilih nama tema: " THEME_NAME

THEME_DIR="$THEMES_DIR/$THEME_NAME"

if [ ! -d "$THEME_DIR" ]; then
    echo "❌ Tema '$THEME_NAME' tidak ditemukan!"
    exit 1
fi

echo ""
echo "🔵 Restoring tema: $THEME_NAME"

# Caelestia user config
if [ -d "$THEME_DIR/caelestia-config" ]; then
    echo "📂 Restoring Caelestia user config..."
    mkdir -p ~/.config/caelestia
    cp -r "$THEME_DIR/caelestia-config/." ~/.config/caelestia/
fi

# Caelestia source
if [ -d "$THEME_DIR/caelestia-source" ]; then
    echo "📂 Restoring Caelestia source..."
    mkdir -p ~/.local/share/caelestia
    rsync -a "$THEME_DIR/caelestia-source/" ~/.local/share/caelestia/
fi

# Quickshell
if [ -d "$THEME_DIR/quickshell" ]; then
    echo "📂 Restoring Quickshell..."
    mkdir -p ~/.config/quickshell
    cp -r "$THEME_DIR/quickshell/." ~/.config/quickshell/
fi

# Config tambahan
for dir in cava fuzzel gtk-3.0 gtk-4.0 autostart spicetify; do
    if [ -d "$THEME_DIR/$dir" ]; then
        mkdir -p ~/.config/$dir
        cp -r "$THEME_DIR/$dir/." ~/.config/$dir/
        echo "  ✓ $dir"
    fi
done

echo ""
echo "✅ Restore selesai! (tema: $THEME_NAME)"
echo "🔄 Silakan restart Hyprland."