#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="omarchy-custom"
TARGET_DIR="/usr/share/sddm/themes/$THEME_NAME"

echo "=== Instalando tema SDDM personalizado ==="
sudo mkdir -p "$TARGET_DIR"
sudo cp -r "$SCRIPT_DIR/sddm-theme/"* "$TARGET_DIR/"

echo "=== Configurando SDDM para usar el tema ==="
sudo mkdir -p /etc/sddm.conf.d
if [[ ! -f /etc/sddm.conf.d/custom-theme.conf ]]; then
  cat <<EOF | sudo tee /etc/sddm.conf.d/custom-theme.conf >/dev/null
[Theme]
Current=$THEME_NAME
EOF
  echo "Tema SDDM configurado: $THEME_NAME"
else
  echo "Config SDDM ya existe, saltando"
fi

echo "Tema SDDM instalado en $TARGET_DIR"
