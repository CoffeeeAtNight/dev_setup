#!/bin/bash

# Fancy setup script for Manjaro Linux
# Automates the installation of essential tools, fonts, and software with minimal interactivity.

# Constants
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Helper Function: Print Info
info() {
    echo -e "${BOLD}${GREEN}[INFO]${RESET} $1"
}

# Helper Function: Print Warning
warning() {
    echo -e "${BOLD}${YELLOW}[WARNING]${RESET} $1"
}

# Step 1: Clean Default Folders
info "Removing unused default folders..."
rm -rf ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

# Step 2: Update Keyring and Repositories
info "Updating keyring and repositories..."
sudo pacman -Sy --noconfirm archlinux-keyring
sudo pacman -Scc --noconfirm
sudo pacman-key --init
sudo pacman-key --populate archlinux manjaro
sudo pacman -Syyu --noconfirm

# Step 3: Install Base Packages
info "Installing base development tools..."
sudo pacman -S --noconfirm base-devel git nano curl wget unzip zip ttf-jetbrains-mono \
    ttf-nerd-fonts-symbols ttf-font-awesome noto-fonts noto-fonts-emoji

# Step 4: Install Developer Tools and Utilities
info "Installing developer tools and programming languages..."
sudo pacman -S --noconfirm neovim python-pip python npm nodejs ripgrep go docker jdk17-openjdk gradle

info "Installing Rust (via rustup)..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

info "Installing Yay (AUR Helper)..."
sudo pacman -S --noconfirm yay

info "Installing Brave Browser..."
yay -S --noconfirm brave-bin

# Step 5: Install and Configure Docker
info "Configuring Docker..."
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# Step 6: Install and Configure Oh My Zsh
info "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    warning "Oh My Zsh is already installed, skipping..."
fi

# Step 7: Install LunarVim
info "Installing LunarVim..."
if command -v lvim >/dev/null 2>&1; then
    warning "LunarVim is already installed, skipping..."
else
    LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
fi

# Step 8: Placeholder for Future Ricing
info "Setting up environment for future ricing..."
mkdir -p "$HOME/.config/rice"

# Step 9: Finalizing Setup
info "Finalizing setup..."
sudo systemctl daemon-reload
sudo systemctl restart docker

info "All done! 🎉 Please log out and log back in to ensure all group changes (like Docker) take effect."
