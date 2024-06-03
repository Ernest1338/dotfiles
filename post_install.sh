#!/bin/bash

set -euo pipefail

# think of using btrfs and creating a snapshot on every update to achive nixos like system resilience

# install additional packages
sudo pacman -Syyu --noconfirm --needed \
    neovim \
    chezmoi \
    neovim \
    chezmoi \
    hyprland \
    hyprlock \
    git \
    base-devel \
    rustup \
    meson \
    cmake \
    cpio \
    lazygit \
    ttf-hack \
    alacritty \
    imv \
    mpv \
    ly \
    i2c-tools \
    wget \
    curl \
    htop \
    ripgrep \
    fd \
    ncdu \
    wl-clipboard \
    fuzzel \
    waybar \
    mako \
    thunar \
    grim \
    slurp \
    python \
    python-lsp-server \
    python-lsp-black \
    uv \
    qemu-base \
    ffmpeg \
    lua-language-server \
    pavucontrol \
    xdg-desktop-portal-hyprland \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-common \
    ttf-nerd-fonts-symbols-mono

# setup paru
wget $(curl -s https://api.github.com/repos/Morganamilo/paru/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep x86_64 | head -1) -O /tmp/paru.tar.zst &&
    mkdir /tmp/paru-bin &&
    tar -xvf /tmp/paru.tar.zst -C /tmp/paru-bin &&
    /tmp/paru-bin/paru -Syy --noconfirm paru-bin &&
    rm -rf /tmp/paru*

# install packages from AUR
paru -S --noconfirm brave-bin hyprpicker

# setup dotfiles
chezmoi init https://github.com/Ernest1338/dotfiles.git
chezmoi apply

# setup git
git config --global credential.helper store
git config --global user.email "ernestgupik@wp.pl"
git config --global user.name "Ernest Gupik"

# enable services
systemctl --user enable --now mako
systemctl enable ly

# setup rust
rustup install nightly
rustup component add rust-analyzer

# install neovim config
git clone https://github.com/Ernest1338/nvim ~/.config/nvim && nvim +q

# network manager set dns to 1.1.1.1 and 9.9.9.9
nmcli -g name,type connection  show  --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
do
  nmcli con mod "$connection" ipv6.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.dns "1.1.1.1 9.9.9.9"
  nmcli con down "$connection" && nmcli con up "$connection"
done

# setup swapfile (ask for size?)
mkswap -U clear --size 8G --file /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab
swapon /swapfile

# on laptop only
read -p "Are you want to apply laptop settings? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # write tlp config > /etc/tlp.conf
    # CPU_ENERGY_PERF_POLICY_ON_AC=performance
    # CPU_ENERGY_PERF_POLICY_ON_BAT=power
    # CPU_MAX_PERF_ON_AC=100
    # CPU_MAX_PERF_ON_BAT=20
    # CPU_MIN_PERF_ON_AC=0
    # CPU_MIN_PERF_ON_BAT=0
    # CPU_SCALING_GOVERNOR_ON_AC=performance
    # CPU_SCALING_GOVERNOR_ON_BAT=powersave
fi

read -p "Do you want to reboot? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    reboot
fi
