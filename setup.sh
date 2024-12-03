rm -rf ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

sudo pacman -Sy archlinux-keyring
sudo pacman -Scc
sudo pacman-key --init
sudo pacman-key --populate archlinux manjaro
sudo pacman -Syyu
sudo pacman -S yay

sudo pacman -S base-devel git nano curl wget unzip zip
sudo pacman -S ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-font-awesome noto-fonts noto-fonts-emoji
sudo pacman -S neovim git make python-pip python npm nodejs ripgrep go docker jdk17-openjdk gradle
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

yay -S brave-bin

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 

