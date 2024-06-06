#!/bin/bash

set -euo pipefail

# think of using btrfs and creating a snapshot on every update to achive nixos like system resilience

# install additional packages
sudo pacman -Syyu --noconfirm --needed \
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
    alacritty \
    imv \
    mpv \
    ly \
    i2c-tools \
    wget \
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
    gnu-netcat \
    xdg-desktop-portal-hyprland \
    ttf-hack \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-common \
    ttf-nerd-fonts-symbols-mono \
    noto-fonts-emoji \
    polkit-gnome \
    hypridle

# setup paru
wget $(curl -s https://api.github.com/repos/Morganamilo/paru/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep x86_64 | head -1) -O /tmp/paru.tar.zst &&
    mkdir /tmp/paru-bin &&
    tar -xvf /tmp/paru.tar.zst -C /tmp/paru-bin &&
    /tmp/paru-bin/paru -Syy --noconfirm paru-bin &&
    rm -rf /tmp/paru*

# install packages from AUR
paru -S --noconfirm --needed brave-bin hyprpicker

# setup git
git config --global credential.helper store
git config --global user.email "ernestgupik@wp.pl"
git config --global user.name "Ernest Gupik"

# enable services
systemctl --user enable --now mako
sudo systemctl enable ly

# setup rust
rustup install nightly
rustup component add rust-analyzer

# install neovim config
git clone https://github.com/Ernest1338/nvim ~/.config/nvim

# network manager set dns to 1.1.1.1 and 9.9.9.9
nmcli -g name,type connection  show  --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
do
  nmcli con mod "$connection" ipv6.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.ignore-auto-dns yes
  nmcli con mod "$connection" ipv4.dns "1.1.1.1 9.9.9.9"
  nmcli con down "$connection" && nmcli con up "$connection"
done

# setup swapfile (ask for size?)
sudo mkswap -U clear --size 8G --file /swapfile
echo "/swapfile none swap defaults 0 0" | sudo tee -a /etc/fstab
sudo swapon /swapfile

# setup dotfiles
chezmoi init https://github.com/Ernest1338/dotfiles.git
chezmoi apply

# make bash history work
mkdir -p ~/.local/state/bash
touch ~/.local/state/bash/history

# on laptop only
read -p "Are you want to apply laptop settings? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    paru -S --noconfirm brightnessctl tlp
    sudo systemctl enable --now tlp
    # write tlp config > /etc/tlp.conf
    echo "
CPU_ENERGY_PERF_POLICY_ON_AC=performance
CPU_ENERGY_PERF_POLICY_ON_BAT=power
CPU_MAX_PERF_ON_AC=100
CPU_MAX_PERF_ON_BAT=20
CPU_MIN_PERF_ON_AC=0
CPU_MIN_PERF_ON_BAT=0
CPU_SCALING_GOVERNOR_ON_AC=performance
CPU_SCALING_GOVERNOR_ON_BAT=powersave
" | sudo tee /etc/tlp.conf
fi
