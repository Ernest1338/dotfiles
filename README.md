# System install and setup

- archinstall
- - language: English
- - Mirrors: Mirror region: Poland
- - Locales: layout=us, language=en_US.UTF-8, encoding=UTF-8
- - Disk encryption: NONE
- - Bootloader: Grub
- - Swap (will create after): False
- - Hostname: archlinux
- - Root password: REDACTED
- - User account: REDACTED (sudoer)
- - Profile: Minimal
- - Audio: Pipewire
- - Kernels: Linux
- - Additional packages: `curl`
- - Network configuration: Use NetworkManager
- - Timezone: Europe/Warsaw
- - NTP: True
- post install step:
```bash
sudo pacman -Syyu --noconfirm chezmoi && chezmoi init --apply Ernest1338
```
