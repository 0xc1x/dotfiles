# Dotfiles

Configuraciones personalizadas para Omarchy (Arch Linux + Hyprland).

## Estructura

```
dotfiles/
├── hypr/              # Hyprland (stow package)
│   └── .config/hypr/
│       ├── hyprland.conf      # Config principal (clipse, cursor, binds)
│       ├── bindings.conf      # Atajos personalizados
│       ├── looknfeel.conf     # Apariencia (gaps, bordes, scrolling)
│       ├── hyprlock.conf      # Lockscreen con ASCII art custom
│       └── ...
├── nvim/              # Neovim (stow package)
│   └── .config/nvim/
│       └── lua/plugins/theme.lua  # Tema Aether custom
├── walker/            # Walker launcher (stow package)
│   └── .config/walker/
│       ├── config.toml        # Tema custom, providers
│       └── omarchy-custom-walker-theme/  # Bordes redondeados
├── zed/               # Zed editor (stow package)
│   └── .config/zed/
│       ├── settings.json      # Tema Aether dark
│       └── themes/aether.json # Tema corregido (sin invisibles)
├── vscode-config/     # VS Code settings (stow package)
│   └── .config/Code/User/settings.json
├── vscode-theme/      # VS Code tema Aether (stow package)
│   └── .vscode/extensions/theme-aether/
├── omarchy/           # Branding Omarchy (stow package)
│   └── .config/omarchy/branding/
│       ├── screensaver.txt    # ASCII art para hyprlock
│       └── logo.png           # Imagen original del logo
├── aether/            # Tema Aether (stow package)
│   ├── .config/aether/
│   │   ├── blueprints/customtheme.json  # Definición de colores y wallpaper
│   │   ├── settings.json                # Config de Aether (apps incluidas)
│   │   ├── theme.css                    # CSS base
│   │   └── theme/aether.override.css    # Override GTK
│   └── .cache/aether/
│       └── wallpaper.jpg       # Wallpaper fuente del tema
├── sddm/              # SDDM login theme (requiere sudo)
│   ├── sddm-theme/            # Archivos del tema (logo.svg, Main.qml)
│   └── install.sh             # Script de instalación
└── packages/          # Gestión de paquetes
    ├── install.sh             # Instalar + eliminar bloatware
    ├── packages.txt           # Paquetes necesarios
    └── bloatware.txt          # Bloatware a eliminar
```

## Instalación en una nueva máquina

### 1. Instalar Omarchy

https://learn.omacom.io/2/the-omarchy-manual/50/getting-started

### 2. Clonar dotfiles

```bash
git clone <url-de-tu-repo> ~/dotfiles
```

### 3. Aplicar dotfiles con stow

```bash
cd ~/dotfiles

stow aether
stow hypr
stow nvim
stow omarchy
stow vscode-config
stow vscode-theme
stow walker
stow zed
```

> Si hay conflictos con archivos existentes, usa `stow --adopt` para que stow
> adopte los archivos actuales y los reemplace con symlinks. Luego verifica
> que el contenido en dotfiles sea el correcto.

### 4. Regenerar tema Aether

El tema Aether se genera desde un wallpaper. La paleta de colores y el
wallpaper están guardados en `aether/.config/aether/blueprints/customtheme.json`.

```bash
# Abrir Aether y cargar el wallpaper desde .cache/aether/wallpaper.jpg
aether
```

Al generar el tema, Aether crea archivos en `~/.config/omarchy/current/theme/`
que todas las apps consumen. Los temas de Zed y VSCode en este repo ya tienen
los colores invisibles corregidos (Aether genera `#000000` para foregrounds
que quedan invisibles sobre fondo negro).

### 5. Instalar tema SDDM personalizado

```bash
~/dotfiles/sddm/install.sh
```

Copia el tema con tu logo personalizado a `/usr/share/sddm/themes/` y
configura SDDM para usarlo.

### 6. Instalar/eliminar paquetes

Edita `packages/bloatware.txt` y descomenta lo que quieras eliminar:

```bash
~/dotfiles/packages/install.sh
```

### 7. Reiniciar servicios

```bash
omarchy-restart-waybar
omarchy-restart-walker
```

## Gestión con stow

- **Aplicar**: `stow <paquete>` desde `~/dotfiles`
- **Quitar**: `stow -D <paquete>` desde `~/dotfiles`
- **Re-aplicar**: `stow -R <paquete>` desde `~/dotfiles`
- **Simular**: `stow -n -v <paquete>` (dry-run)

## Notas

- **Tema Aether**: Los archivos en `~/.config/omarchy/current/theme/` se
  autogeneran desde la app Aether. Lo que se guarda en dotfiles es la
  **definición** (blueprint, wallpaper, settings, overrides) para poder
  regenerarlo. Los archivos de tema de Zed y VSCode sí están corregidos
  manualmente porque Aether genera colores invisibles.
- **Hyprland**: Los archivos en `~/.config/hypr/` sobreescriben los defaults
  de Omarchy (cargados desde `~/.local/share/omarchy/default/hypr/`).
- **Clipse**: Configurado en `hyprland.conf` con `exec-once = clipse -listen`
  y `bind = SUPER, V`.
- **Walker**: Tema custom con `border-radius: 16px` (contenedor) y
  `border-radius: 12px` (barra de búsqueda).
- **Zed/VSCode**: Temas Aether con colores `#000000` corregidos (comentarios,
  line numbers, placeholders, inactive tabs, etc.).
- **Screensaver**: ASCII art generado desde imagen PNG con
  `omarchy-transcode-ascii imagen.png ~/.config/omarchy/branding/screensaver.txt --mode block`
- **SDDM**: Logo personalizado embebido como SVG en el tema de login.
