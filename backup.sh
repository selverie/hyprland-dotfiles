#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DATE=$(date +"%Y-%m-%d %H:%M:%S")

echo "🔵 Starting dotfiles backup..."
echo "📁 Target: $DOTFILES_DIR"

# Buat folder dotfiles kalau belum ada
mkdir -p "$DOTFILES_DIR"

# ─────────────────────────────────────────
# 1. Caelestia user config (~/.config/caelestia/)
# ─────────────────────────────────────────
echo "📦 Backing up Caelestia user config..."
mkdir -p "$DOTFILES_DIR/caelestia-config"
cp -r ~/.config/caelestia/. "$DOTFILES_DIR/caelestia-config/"

# ─────────────────────────────────────────
# 2. Caelestia source (~/.local/share/caelestia/)
# ─────────────────────────────────────────
echo "📦 Backing up Caelestia source..."
mkdir -p "$DOTFILES_DIR/caelestia-source"
cp -r ~/.local/share/caelestia/. "$DOTFILES_DIR/caelestia-source/"

# ─────────────────────────────────────────
# 3. Quickshell (~/.config/quickshell/)
# ─────────────────────────────────────────
if [ -d ~/.config/quickshell ]; then
    echo "📦 Backing up Quickshell..."
    mkdir -p "$DOTFILES_DIR/quickshell"
    cp -r ~/.config/quickshell/. "$DOTFILES_DIR/quickshell/"
fi

# ─────────────────────────────────────────
# 4. Config tambahan
# ─────────────────────────────────────────
echo "📦 Backing up extra configs..."

for dir in cava fuzzel gtk-3.0 gtk-4.0 autostart spicetify; do
    if [ -d ~/.config/$dir ]; then
        mkdir -p "$DOTFILES_DIR/$dir"
        cp -r ~/.config/$dir/. "$DOTFILES_DIR/$dir/"
        echo "  ✓ $dir"
    fi
done

# ─────────────────────────────────────────
# 5. Git push
# ─────────────────────────────────────────
cd "$DOTFILES_DIR"

if [ ! -d .git ]; then
    echo ""
    echo "⚠️  Git belum diinit. Jalankan dulu:"
    echo "   cd ~/dotfiles"
    echo "   git init"
    echo "   git remote add origin https://github.com/USERNAME/dotfiles.git"
    echo "   git push -u origin main"
else
    echo ""
    echo "🚀 Pushing to GitHub..."
    git add .
    git commit -m "backup: $BACKUP_DATE"
    git push
    echo "✅ Backup selesai!"
fi