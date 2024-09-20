if status is-interactive
    # NOTE: theme: ayu Mirage, prompt: hydro
    set -g fish_greeting
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx XDG_CONFIG_HOME "$HOME"/.config
    set -gx XDG_STATE_HOME "$HOME"/.local/state
    set -gx XDG_CACHE_HOME "$HOME"/.cache
    set -gx HISTFILE "$XDG_STATE_HOME"/bash/history
    set -gx HISTSIZE 500
    set -gx HISTFILESIZE 1000
    set -gx GNUPGHOME "$XDG_DATA_HOME"/gnupg
    set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
    set -gx LESSHISTFILE "$XDG_CACHE_HOME"/less/history
    set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME"/python/pythonrc
    set -gx XINITRC "$XDG_CONFIG_HOME"/X11/xinitrc
    set -gx CARGO_TARGET_DIR "$HOME/Programming/CargoTarget"
    set -gx GOPATH "$HOME/Programming/GoPath"
    set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/ripgreprc"
    set -gx PATH "$PATH:~/Repos/nspawn-registry/:~/.local/bin:~/.bun/bin:~/.config/composer/vendor/bin"
    set -gx EDITOR "nvim"
    set -gx SHELL "/bin/bash"

    alias vim="nvim"
    alias v="nvim"
    alias vi="nvim --noplugin -u /etc/xdg/nvim/sysinit.vim"
    alias cp="cp -i" # confirm before overwriting something
    alias more=less
    alias ls="ls --color=auto"
    alias l="ls --color=auto"
    alias ll="ls -lah --color=auto"
    alias c="cd"
    alias ip="ip --color=auto"
    alias sudo="sudo " # this makes the aliases work with sudo (for some reason)
    alias cachec="sudo bash -c 'sync; echo 3 > /proc/sys/vm/drop_caches'"
    alias pyserv="python3 -m http.server 8080"
    alias up="paru; chezmoi update; rustup update" # ; flatpak update
    alias dots="chezmoi"
    alias docker=podman
    alias alpvm="podman run --rm -it alpine";
    alias gamingcont="podman run -it -e DISPLAY --ipc=host --device /dev/dri/card1 -v /dev/input:/dev/input -v /etc/machine-id:/etc/machine-id -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/snd -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR --group-add audio -v ~/.config/pulse/cookie:/root/.config/pulse/cookie --privileged --name gaming_container archlinux"
    alias archvm="podman run --rm -it -e DISPLAY --ipc=host --device /dev/dri/card1 -v /dev/input:/dev/input -v /etc/machine-id:/etc/machine-id -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/snd -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR --group-add audio -v ~/.config/pulse/cookie:/root/.config/pulse/cookie --privileged archlinux"
    alias hackingvm="pushd $HOME/Files/VMs && ./hackingvm.sh && popd"
    alias lg=lazygit

    bind \ck up-or-search
    bind \cj down-or-search
    bind \ch backward-word
    bind \cl forward-word

    set -g hydro_color_pwd "yellow"
    set -g hydro_color_git "green"
    set -g hydro_color_duration "brblue"
    set -g hydro_color_prompt "magenta"
    # set -g hydro_multiline true
    # set -g fish_prompt_pwd_dir_length 0
    # TODO: change highlight color

    set -g vi_mode_color "blue"

    # fish_vi_key_bindings
end

function screenrecord
    if not pactl list sinks | grep -q 'Name: MicAndPC'
        echo "Creating MicAndPC sink..."
        pactl load-module module-null-sink sink_name=MicAndPC
        pactl load-module module-loopback sink=MicAndPC source=alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
        pactl load-module module-loopback sink=MicAndPC source=alsa_input.usb-MICE_MICROPHONE_USB_MICROPHONE_201308-00.mono-fallback
    end

    wf-recorder -o HDMI-A-1 --audio=MicAndPC.monitor -c h264_vaapi -C aac -d /dev/dri/renderD128 --file=$HOME/Videos/screencast_(date +%Y%m%d-%H%M%S).mp4
end

function mnt
    if test (count $argv) -lt 1
        echo "Usage: mnt <device> <mount_directory_name>"
        return 1
    end

    set DEVICE $argv[1]
    set MOUNT_DIR $argv[2]

    if test -z "$MOUNT_DIR"
        set MOUNT_DIR (random | md5sum | head -c 20)
    end

    set MOUNT_PATH "/run/media/$USER/$MOUNT_DIR"

    # Create the mount directory if it does not exist
    if not test -d "$MOUNT_PATH"
        sudo mkdir -p "$MOUNT_PATH"
    end

    # Mount the device
    sudo mount "$DEVICE" "$MOUNT_PATH" -o uid=1000,gid=1000,dmask=0022,fmask=133

    # Check if the mount was successful
    if test $status -eq 0
        echo "Successfully mounted $DEVICE to $MOUNT_PATH"
        echo "Press enter to umount..."
    else
        echo "Failed to mount $DEVICE"
        return 1
    end

    read
    sudo umount "$MOUNT_PATH" && sudo rmdir "$MOUNT_PATH" && echo "Successfully unmounted $DEVICE"
end
