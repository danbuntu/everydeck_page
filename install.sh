#!/bin/bash
# Install dependencies and set up Page

set -e

# Install WebKitGTK and Python GObject bindings
if command -v apt-get &>/dev/null; then
    sudo apt-get install -y python3 gir1.2-webkit2-4.1 python3-gi
elif command -v dnf &>/dev/null; then
    sudo dnf install -y python3 webkit2gtk4.1 python3-gobject
elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm python webkit2gtk python-gobject
else
    echo "Unsupported package manager. Install manually: python3, WebKitGTK 4.1, PyGObject" >&2
    exit 1
fi

# Make executable and symlink to PATH
chmod +x "$(dirname "$0")/page"
sudo ln -sf "$(realpath "$(dirname "$0")/page")" /usr/local/bin/page

echo "Installed. Usage: page <url>"
