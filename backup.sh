#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Tanya nama tema
echo "🎨 Nama tema yang ingin dibackup (contoh: caelestia):"
read -p "→ " THEME_NAME

THEME_DIR="$DOTFILES_DIR/themes/$THEME_NAME"

echo ""
echo "🔵 Starting dotfiles backup..."
echo "📁 Target: $THEME_DIR"

# Buat folder tema
mkdir -p "$THEME_DIR"

# ─────────────────────────────────────────
# 1. Caelestia user config (~/.config/caelestia/)
# ─────────────────────────────────────────
echo "📦 Backing up Caelestia user config..."
mkdir -p "$THEME_DIR/caelestia-config"
cp -r ~/.config/caelestia/. "$THEME_DIR/caelestia-config/"

# ─────────────────────────────────────────
# 2. Caelestia source (~/.local/share/caelestia/)
# ─────────────────────────────────────────
echo "📦 Backing up Caelestia source..."
mkdir -p "$THEME_DIR/caelestia-source"
rsync -a --exclude='.git' ~/.local/share/caelestia/ "$THEME_DIR/caelestia-source/"

# ─────────────────────────────────────────
# 3. Quickshell (~/.config/quickshell/)
# ─────────────────────────────────────────
if [ -d ~/.config/quickshell ]; then
    echo "📦 Backing up Quickshell..."
    mkdir -p "$THEME_DIR/quickshell"
    cp -r ~/.config/quickshell/. "$THEME_DIR/quickshell/"
fi

# ─────────────────────────────────────────
# 4. Config tambahan
# ─────────────────────────────────────────
echo "📦 Backing up extra configs..."

for dir in cava fuzzel gtk-3.0 gtk-4.0 autostart spicetify; do
    if [ -d ~/.config/$dir ]; then
        mkdir -p "$THEME_DIR/$dir"
        cp -r ~/.config/$dir/. "$THEME_DIR/$dir/"
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
    git commit -m "backup [$THEME_NAME]: $BACKUP_DATE"
    git push
    echo "✅ Backup selesai! (tema: $THEME_NAME)"
fi