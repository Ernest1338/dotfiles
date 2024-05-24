#!/bin/bash

# install additional packages
sudo pacman -S --noconfirm --needed \
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
    xdg-desktop-portal-hyprland

# TODO (only needed) install fonts: ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-mono

# on laptop: brightnessctl tlp
# write tlp config > /etc/tlp.conf
# CPU_ENERGY_PERF_POLICY_ON_AC=performance
# CPU_ENERGY_PERF_POLICY_ON_BAT=power
# CPU_MAX_PERF_ON_AC=100
# CPU_MAX_PERF_ON_BAT=20
# CPU_MIN_PERF_ON_AC=0
# CPU_MIN_PERF_ON_BAT=0
# CPU_SCALING_GOVERNOR_ON_AC=performance
# CPU_SCALING_GOVERNOR_ON_BAT=powersave

# setup paru

# install packages from AUR
# brave-bin hyprpicker

# chezmoi init https://github.com/Ernest1338/dotfiles.git

# setup git (username, useremail, credential helper store)

# systemctl --user enable --now mako
# for waybar: create new under .config (save with chezmoi)
# systemctl enable ly

# network manager set dns to 1.1.1.1 and 9.9.9.9

# TODO: figure out a way to run this on every boot but only once (bash_profile? hyprland hook?)
# xhost + local:

# install neovim config
