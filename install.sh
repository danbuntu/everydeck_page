#!/bin/bash
# Install dependencies and set up Page

set -e

# Install WebKitGTK and Python GObject bindings
if command -v apt-get &>/dev/null; then
    case "$(dpkg --print-architecture 2>/dev/null)" in
        i386|armhf|armel) GTK_PKG="libgtk-3-0t64" ;;
        *) GTK_PKG="libgtk-3-0" ;;
    esac
    sudo apt-get install -y python3 python3-gi gir1.2-gtk-3.0 "$GTK_PKG" gir1.2-webkit2-4.1
elif command -v dnf &>/dev/null; then
    sudo dnf install -y python3 webkit2gtk4.1 python3-gobject
elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm python webkit2gtk python-gobject
else
    echo "Unsupported package manager. Install manually: python3, WebKitGTK 4.1, PyGObject" >&2
    exit 1
fi

# Make executable and symlink to PATH
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ ! -f "$SCRIPT_DIR/page" ]; then
    echo "Error: 'page' script not found in $SCRIPT_DIR. Make sure you cloned the full repository." >&2
    exit 1
fi
sed -i 's/\r//' "$SCRIPT_DIR/page"
chmod +x "$SCRIPT_DIR/page"
sudo ln -sf "$SCRIPT_DIR/page" /usr/local/bin/page

echo "Installed. Usage: page <url>"
