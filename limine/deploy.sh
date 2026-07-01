#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Deploying Limine bootloader config..."

sudo cp "$SCRIPT_DIR/limine.conf" /boot/limine.conf
sudo cp "$SCRIPT_DIR/assets/xcix-logo.png" /boot/EFI/limine/xcix-logo.png

echo "Done! Reboot to see changes."
