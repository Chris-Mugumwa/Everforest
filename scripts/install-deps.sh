#!/bin/bash
# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                    Dotfiles Dependency Installer                           ┃
# ┃  Installs all packages required for the Hyprland desktop environment       ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}       Hyprland Dotfiles Dependency Installer${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if running on Arch-based system
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Error: This script requires pacman (Arch Linux or derivative)${NC}"
    exit 1
fi

# Check for AUR helper
AUR_HELPER=""
if command -v paru &> /dev/null; then
    AUR_HELPER="paru"
elif command -v yay &> /dev/null; then
    AUR_HELPER="yay"
else
    echo -e "${YELLOW}Warning: No AUR helper found (paru or yay)${NC}"
    echo -e "${YELLOW}AUR packages will be skipped. Install paru or yay first.${NC}"
fi

# Install official packages
echo -e "\n${GREEN}[1/3] Installing official packages...${NC}"
if [ -f "$DOTFILES_DIR/pkglist.txt" ]; then
    # Filter out comments and empty lines
    grep -v '^#' "$DOTFILES_DIR/pkglist.txt" | grep -v '^$' | sudo pacman -S --needed -
else
    echo -e "${RED}Error: pkglist.txt not found in $DOTFILES_DIR${NC}"
    exit 1
fi

# Install AUR packages
if [ -n "$AUR_HELPER" ]; then
    echo -e "\n${GREEN}[2/3] Installing AUR packages with $AUR_HELPER...${NC}"
    if [ -f "$DOTFILES_DIR/pkglist-aur.txt" ]; then
        grep -v '^#' "$DOTFILES_DIR/pkglist-aur.txt" | grep -v '^$' | $AUR_HELPER -S --needed -
    else
        echo -e "${YELLOW}Warning: pkglist-aur.txt not found, skipping AUR packages${NC}"
    fi
else
    echo -e "\n${YELLOW}[2/3] Skipping AUR packages (no helper found)${NC}"
fi

# Enable bluetooth service
echo -e "\n${GREEN}[3/3] Enabling services...${NC}"
sudo systemctl enable --now bluetooth.service 2>/dev/null || echo -e "${YELLOW}Bluetooth service already enabled or not available${NC}"

echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}                    Installation Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Next steps:"
echo -e "  1. Symlink your dotfiles: ${YELLOW}stow . --target=\$HOME${NC}"
echo -e "  2. Log out and select Hyprland from your display manager"
echo -e "  3. Or run: ${YELLOW}Hyprland${NC}"
echo ""
