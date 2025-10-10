# Get bash source
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# Detect package manager
if command -v apt-get >/dev/null 2>&1; then
    PM="apt-get"
    INSTALL="apt-get install -y"
elif command -v pkg >/dev/null 2>&1; then
    PM="pkg"
    INSTALL="pkg install -y"
elif command -v dnf >/dev/null 2>&1; then
    PM="dnf"
    INSTALL="dnf install -y"
elif command -v pacman >/dev/null 2>&1; then
    PM="pacman"
    INSTALL="pacman -S --noconfirm"
else
    echo "Unsupported distro or package manager. Please install clang, clang++, and nano manually."
    exit 1
fi

echo "Detected package manager: $PM"
echo "Installing packages: nano, clang, clang++"

# For distros where clang++ is part of clang, we just install clang
case "$PM" in
    apt-get|pkg|dnf)
        $INSTALL clang nano
        ;;
    pacman)
        $INSTALL clang nano
        ;;
esac

# Verify installation
for cmd in clang clang++ nano; do
    if ! command -v $cmd >/dev/null 2>&1; then
        echo "Error: $cmd failed to install."
    else
        echo "$cmd installed successfully!"
    fi
done

# Make sure that all necessary directories exist and have the right permissions
if sudo ls  >/dev/null 2>&1 &; then
    "SUDO=true"
fi
if [ "$SUDO" == "true" ]; then
    sudo mkdir "$DIR/src"
    sudo mkdir "$DIR/compiled"
    sudo mkdir "$DIR/tmp"
    sudo chmod -R +xrw "$DIR"
else
    mkdir "$DIR/src"
    mkdir "$DIR/compiled"
    mkdir "$DIR/tmp"
    chmod -R +xrw "$DIR"
fi
