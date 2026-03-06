![Snowflake CI](https://github.com/komi7/snowflake/actions/workflows/check.yml/badge.svg)

❄️ Snowflake Config (KOMI7)

A modular, flake-based NixOS configuration for the KOMI workstation. Designed with a "Floating Island" aesthetic, high-performance NVIDIA optimizations, and full Bengali typography support.

## 🗺️ Table of Contents
* [📸 Screen Preview](#️-Screen-Preview)
* [⚠️ Hardware Warning](#️-hardware-warning--compatibility)
* [📂 Project Structure](#-project-structure)
* [✨ Features & Fixes](#-features--fixes)
* [🚀 Quick Start](#-quick-start)
* [🧹 Maintenance](#-maintenance-routine)
* [📜 License](#-license)

📸 Screen Preview
![Preview](https://private-user-images.githubusercontent.com/109201315/559118746-5e6c7261-7f27-4697-b5b1-e3d0bf53d877.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzI3NzUwNDUsIm5iZiI6MTc3Mjc3NDc0NSwicGF0aCI6Ii8xMDkyMDEzMTUvNTU5MTE4NzQ2LTVlNmM3MjYxLTdmMjctNDY5Ny1iNWIxLWUzZDBiZjUzZDg3Ny5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMzA2JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDMwNlQwNTI1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04OTM4NTRiNjFmNDZiNzJiNWFlNmM3NmUzZDNmNTNhZmY4MDFhNmMyNDQxNDljNjRkNmFhN2I4Nzk1ZDVhZGI1JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.QLlfzB5ZAvQe6f9JLeY8AyhmCmJJK972uOn6V3KKiok)

⚠️ Hardware Warning & Compatibility

    [!IMPORTANT]
    This configuration is hardware-specific. Running it on incompatible systems without modification may result in a boot failure.

1. GPU: NVIDIA Proprietary Drivers

Optimized for NVIDIA Turing (16/20 series) or newer via the nvidia.nix module.

    Kernel Parameters: Enables nvidia_drm.modeset=1 and fbdev=1 for Wayland stability.

    Action: If using AMD or Intel, remove the nvidia.nix import from hosts/KOMI/configuration.nix before rebuilding.

2. Bootloader & Storage

    Uses systemd-boot for UEFI systems.

    Drive UUIDs are hardware-dependent; ensure hardware-configuration.nix matches your disk layout.


## 📂 Project Structure
```bash
snowflake/
├── flake.nix            # System entry point & input locking
├── flake.lock           # Version hashes for nixpkgs/hyprland
├── hosts/
│   └── KOMI/            # Machine-specific settings
│       ├── configuration.nix   # Main system imports
│       └── hardware-configuration.nix # UUIDs & Kernel Modules
└── modules/
    ├── home/            # User-level (Home Manager)
    │   ├── waybar.nix   # "Floating Island" UI & CSS
    │   └── hyprland.nix # Keybinds & Window Rules
    └── system/          # System-level (NixOS)
        ├── core.nix     # Essential apps (Zen, Brave)
        ├── fontconfig.nix # Bengali & Nerd Font setup
        ├── nvidia.nix   # GPU drivers & Wayland patches
        └── steam.nix    # Gaming & 32-bit support
```
✨ Features & Fixes
🏝️ Waybar "Floating Island" UI

The bar is segmented into three isolated rounded segments using custom CSS and Gtk portal integration:

    Left Island: Dynamic App Focus (Icon + regex-cleaned titles).

    Center Island: Stats Island (CPU/RAM/Workspaces/Clock).

    Right Island: Utility Island (System Tray/Audio/Battery/Power).

🧬 The "Picosvg" Build Bypass

To avoid common Python 3.13 build failures with font tools:

    Binary Caching: Prioritizes cache.nixos.org to skip local compilation.

    Nerd-Fonts Binaries: Uses pre-built symbols to ensure icons work out-of-the-box.

🔤 Multi-Language Typography

    Main: JetBrainsMono Nerd Font.

    Bengali: Kalpurush (Custom Derivation) & Noto Sans Bengali.

    Fallback: Symbols-only Nerd Font for system-wide glyph support.

🚀 Quick Start

    Clone the Repo:
    Bash

    git clone https://github.com/komi7/snowflake.git
    cd snowflake

    Stage Changes (Critical for Flakes):
    Bash

    git add .

    Deploy:
    Bash

    sudo nixos-rebuild switch --flake .#KOMI

🧹 Maintenance Routine
Command	Purpose
nix flake update	Update all inputs (Kernel, Hyprland, etc.)
sudo nix-collect-garbage -d	Deep clean old generations (Free space)
fc-cache -fv	Refresh font cache for new icons
systemctl --user reset-failed	Clear failed status logs for Waybar/Portals

📜 License
This project is licensed under the MIT License. Feel free to fork and rice!
