#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="xcix"
TARGET_DIR="/usr/share/plymouth/themes/$THEME_NAME"

echo "=== Instalando tema Plymouth personalizado ==="
sudo mkdir -p "$TARGET_DIR"
sudo cp -r "$SCRIPT_DIR/plymouth-theme/"* "$TARGET_DIR/"

echo "=== Configurando Plymouth para usar el tema ==="
sudo plymouth-set-default-theme "$THEME_NAME"

echo "=== Regenerando initramfs ==="
if command -v limine-mkinitcpio &>/dev/null; then
  sudo limine-mkinitcpio
else
  sudo mkinitcpio -P
fi

echo "Tema Plymouth instalado: $THEME_NAME"
