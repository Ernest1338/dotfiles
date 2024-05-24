# System install and setup

- archinstall
- - language: English
- - Mirrors: Mirror region: Poland
- - Locales: layout=us, language=en_US.UTF-8, encoding=UTF-8
- - Disk encryption: NONE
- - Bootloader: Grub
- - Swap (will create after): False
- - Hostname: dvdarch
- - Root password: REDACTED
- - User account: REDACTED (sudoer)
- - Profile: Minimal
- - Audio: Pipewire
- - Kernels: Linux
- - Additional packages: `neovim chezmoi`
- - Network configuration: Use NetworkManager
- - Timezone: Europe/Warsaw
- - NTP: True
- post install script
- chezmoi init https://github.com/Ernest1338/dotfiles.git


