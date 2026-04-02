#!/bin/bash
echo "=== Instalando paquetes explícitos ==="
sudo pacman -S --needed - < packages.txt

echo "=== Actualizando sistema ==="
sudo pacman -Syu

echo "¡Paquetes instalados!"
