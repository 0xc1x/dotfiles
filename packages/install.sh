#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Instalando paquetes necesarios ==="
sudo pacman -S --needed - < "$SCRIPT_DIR/packages.txt"

echo ""
echo "=== Eliminando bloatware ==="
if [[ -f "$SCRIPT_DIR/bloatware.txt" ]]; then
  TO_REMOVE=()
  while IFS= read -r line; do
    line="${line%%#*}"
    line="$(echo "$line" | xargs)"
    if [[ -n "$line" ]]; then
      if pacman -Qi "$line" &>/dev/null; then
        TO_REMOVE+=("$line")
      fi
    fi
  done < "$SCRIPT_DIR/bloatware.txt"

  if (( ${#TO_REMOVE[@]} > 0 )); then
    echo "Se eliminarán: ${TO_REMOVE[*]}"
    sudo pacman -Rns "${TO_REMOVE[@]}"
  else
    echo "No hay paquetes para eliminar (todos descomentados o no instalados)"
  fi
else
  echo "No existe bloatware.txt, saltando eliminación"
fi

echo ""
echo "=== Actualizando sistema ==="
sudo pacman -Syu

echo ""
echo "=== Instalando extensiones AUR (si yay está disponible) ==="
if command -v yay &>/dev/null; then
  yay -S --needed --noconfirm visual-studio-code-bin 1password-beta 2>/dev/null || true
fi

echo ""
echo "¡Listo! Paquetes instalados y bloatware eliminado."
