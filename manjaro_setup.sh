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

# Step 1: Clean Default Folders and create dev folder
info "Removing unused default folders..."
rm -rf ~/Music ~/Public ~/Templates ~/Videos ~/Desktop
mkdir ~/dev
mv ../dev_setup ~/dev

# Step 2: Update Keyring and Repositories
info "Updating keyring and repositories..."
sudo pacman -Sy --noconfirm archlinux-keyring
sudo pacman -Scc --noconfirm
sudo pacman-key --init
sudo pacman-key --populate archlinux manjaro
sudo pacman -Syyu --noconfirm

# Step 3: Install Base Packages
info "Installing base development tools..."
sudo pacman -S --noconfirm base-devel git feh nano curl wget unzip zip ttf-jetbrains-mono \
  ttf-nerd-fonts-symbols ttf-font-awesome noto-fonts noto-fonts-emoji

# Step 4: Install Nerd Fonts via Installer
info "Installing Nerd Fonts..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"

# Step 5: Install Developer Tools and Utilities
info "Installing developer tools and programming languages..."
sudo pacman -S --noconfirm neovim python-pip python npm nodejs ripgrep go docker jdk17-openjdk gradle

info "Installing Rust (via rustup)..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

info "Installing Yay (AUR Helper)..."
sudo pacman -S --noconfirm yay

info "Installing Zen Browser..."
yay -S zen-browser-bin --noconfirm

info "Configuring Docker..."
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# Step 7: Install and Configure Alacritty
info "Installing Alacritty..."
sudo pacman -S --noconfirm alacritty

info "Configuring Alacritty..."
ALACRITTY_CONFIG_DIR="$HOME/.config/alacritty"
mkdir -p "$ALACRITTY_CONFIG_DIR"

if [ -f "alacritty.toml" ]; then
  cp alacritty.toml "$ALACRITTY_CONFIG_DIR/alacritty.toml"
  info "Alacritty configuration (TOML) copied to $ALACRITTY_CONFIG_DIR."
else
  warning "alacritty.toml not found in the current directory. Please copy it manually to $ALACRITTY_CONFIG_DIR."
fi

# Step 8: Set Alacritty as Default Terminal Emulator
info "Setting Alacritty as the default terminal emulator..."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# Step 9: Install and Configure Oh My Zsh
info "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  warning "Oh My Zsh is already installed, skipping..."
fi

# Step 10: Install LunarVim
info "Installing LunarVim..."
if command -v lvim >/dev/null 2>&1; then
  warning "LunarVim is already installed, skipping..."
else
  LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
fi
cp -f config.lua ~/.config/lvim

yay -S pokemon-colorscripts-git --noconfirm

# Step 11: Install custom stuff
info "Installing fun stuff"
sudo pacman -S --noconfirm spotify-launcher
sudo pacman -S --noconfirm discord
sudo pacman -S --noconfirm steam
# Add more stuff if needed in the future <3

# Step 12: Placeholder for Future Ricing
info "Setting up environment for future ricing..."
mkdir -p "$HOME/.config/rice"

# Step 13: Place Wallpaper in rice folder
cp ./wallpaper.png "$HOME/.config/rice"

# Step 14: Setup Git
info "Checking if SSH key already exists..."
if [ -f "$HOME/.ssh/id_ed25519" ]; then
  info "SSH key already exists. Skipping key generation."
else
  info "Generating SSH key..."
  ssh-keygen -t ed25519 -C "contact@aki-dev.com" -f "$HOME/.ssh/id_ed25519" -N ""
  info "SSH key generated successfully."
fi

info "Public key is:"
cat "$HOME/.ssh/id_ed25519.pub"

# Step 15: Apply i3 config
info "Applying i3 config"
cp ~/.i3/config ~/.i3/config.bak
cp -f ./config ~/.i3/
cp -f ./i3blocks.conf ~/.i3/
i3-msg reload

# Step 16: Finalizing Setup
info "Finalizing setup..."
sudo systemctl daemon-reload
sudo systemctl restart docker
rm -r JetBrainsMono.zip
cat .ssh/
source ~/.zshrc

info "All done! 🎉 Please log out and log back in to ensure all group changes (like Docker) take effect."
info "Logging out of desktop session in 5 seconds to apply i3 settings ..."

wait 5
