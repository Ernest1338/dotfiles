# System install and setup

- archinstall
- - language: English
- - Mirrors: Mirror region: Poland
- - Locales: layout=us, language=en_US.UTF-8, encoding=UTF-8
- - Disk configuration: best-effort, ext4, no separate home
- - Disk encryption: NONE
- - Bootloader: Grub
- - Swap (will create after): False
- - Hostname: archlinux
- - Root password: REDACTED
- - User account: REDACTED (sudoer)
- - Profile: Minimal
- - Audio: Pipewire
- - Kernels: Linux
- - Additional packages: `curl neovim`
- - Network configuration: Use NetworkManager
- - Timezone: Europe/Warsaw
- - NTP: True
- post install step:
```bash
curl -o post_install.sh https://raw.githubusercontent.com/Ernest1338/dotfiles/main/post_install.sh && bash post_install.sh && rm post_install.sh && reboot
```
