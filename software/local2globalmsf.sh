#!/bin/bash
if [ ! -d "$HOME/.msf4/modules/auxiliary" ]; then
    echo "Metasploit is not installed or the directory does not exist."
    exit 1
fi
sudo cp -r msfmodules/* $HOME/.msf4/modules/auxiliary/
current_user=$(whoami)
# TODO: ensure that not duplicated
for file in "$HOME/VPTP/software/msfsubmodules"/*; do
    sudo cp "$file" /usr/bin/
    entry="$current_user ALL=(ALL) NOPASSWD: /usr/bin/$(basename "$file")"
    if ! sudo grep -Fxq "$sudoers_entry" /etc/sudoers; then
        echo "$entry" | sudo tee -a /etc/sudoers
    fi
done
