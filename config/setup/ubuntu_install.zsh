#!/usr/bin/env zsh

username=${1-'jvandezande'}

if [ ! -f ~/.ssh/id_rsa.pub ]
then
    ssh-keygen
    ls -al ~/.ssh
    echo "Setup your ssh key with GitHub"
    cat ~/.ssh/id_rsa.pub
    echo "Press any key when ready"
    read
fi

ssh -T git@github.com

LOCAL_USER=$USER

# Run script as root if not already.
if [[ $EUID -ne 0 ]]; then
    exec sudo REAL_USER=${LOCAL_USER} /usr/bin/env bash "$0" "$@"
fi

mkdir -p ~/progs ~/tmp

echo "Adding repos!"


echo "Apt!"
apt-get update

apt_progs=(
    autoconf        # PSI4
    avogadro        # Visualizing molecules and MM
    build-essential # compiler needs
    clang           # compiler
    cmake           # PSI4
    curl            # Downloading stuff from the web
    compizconfig-settings-manager # For changing computer defaults
    compiz-plugins  # Extension to ccsm
    eigen           # Matrix library
    fd-find         # Much faster than `find`
    g++             # C++ compiler
    gfortran        # PSI4
    git             # VCS
    gkrellm         # System monitor
    google-chrome   # Browser
    golang          # Go language
    gparted         # Disk partitioning tool
    gummi           # Simple LaTeX editor
    i3              # Tiling window manager
    # jmol# Molecule visualizer
    keepassx        # Password storage
    libatk-adaptor  # For inkscape
    libblas-dev     # PSI4, OpenChemistry
    libboost-all-dev # PSI4
    libbz2-1.0      # OpenChemistry
    libbz2-dev      # OpenChemistry
    libbz2-ocaml    # OpenChemistry
    libbz2-ocaml-dev # OpenChemistry
    libffi-dev      # Cairocffi dependency (used in Matplotlib)
    liblapack-dev   # PSI4, OpenChemistry
    libeigen3-dev   # Eigen
    libfreetype6-dev # Matplotlib
    libgail-common  # Inkscape
    libjpeg-dev     # cheMVP
    libopenmpi2     # OpenMPI
    libpng-dev      # cheMVP, Matplotlib
    libqt5designer5 # OpenChemistry
    libqt5svg5-dev  # cheMVP
    libssl-dev      # Compiling Python3
    libtiff-dev     # cheMVP
    libxml2-dev     # Avogadro2
    make            # compilation
    neofetch        # System properties display
    python3-dropbox # Dropbox
    neovim          # Neovim
    openconnect     # VPN (alternative to Cisco AnyConnect)
    openjdk-8-jre   # Java
    openssh-server  # SSH
    openssl         # Compiling Python3
    pinta           # Lightwieght raster graphic editor
    povray          # Ray tracer
    python3-dev     # Python3
    python3-pip     # Python3 package installer
    python3-setuptools # setting up python packages
    python3-pyqt5   # Python3 qt5 bindings
    qt5-default     # cheMVP
    rclone          # Rscync for cloud storage
    rcm             # Dotfile manager
    ruby-dev        # Programming language (used for Travis)
    snapd           # Snap installer
    swi-prolog      # Prolog implementation
    texlive-full    # Full tex distribution (very large)
    vim             # Editor
    zplug           # Zsh plugin installer
    zsh             # Shell
)

for prog in "${apt_progs[@]}"
do
    echo $prog
    apt-get install $prog -y
done

apt-get update
apt-get upgrade -y
apt-get autoremove


echo "PIP!"
pip_progs=(
# Python libraries
    ipython[all]
    matplotlib
    more_itertools
    natsort
    numpy
# Coding tools
    mypy
    black
    flake8
)

for prog in "${pip_progs[@]}"
do
    echo $prog
    pip3 install $prog
done


echo "Snaps!"
snap_progs=(
    firefox             # Browser
    gimp                # Raster graphic editor
    inkscape            # Vector graphics editor
    keepassxc           # Password storage
    pycharm-community   # Python IDE
    spotify             # Music player
    valgrind            # Code checker
)

for prog in "${snap_progs[@]}"
do
    echo $prog
    snap install $prog
done


#############
# Userspace #
#############

# Vim-plug
echo "Vim-Plug!"
if [ ! -f ~/.dotfiles/.vim/autoload/plug.vim ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Zplug
echo "Zplug!"
if [ ! -d ~/.zplug ]
then
    curl -sL --proto-redir -all,https \
        https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

echo "Git programs!"
git_progs=(
    dotfiles
    qgrep
    spectra
)
for prog in $git_progs
do
    if [ ! -d ~/progs/$prog ]
    then
        git clone git@github.com:jevandezande/$prog ~/progs/$prog
        pushd ~/progs/$prog
            git update
            git submodule init
            git submodule update
        popd
    fi
done

mv progs/dotfiles ~/.dotfiles
rcup


# Rust
echo "Rust!"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Conda!"
zsh ~/.dotfiles/config/conda_install.zsh


chsh zsh
# Change ownership from root to user
#chown $username -R ~/.dotfiles
#chown $username -R ~/.zplug
#chown $username -R ~/progs
#chsh $username -s /bin/zsh

# Facial recognition login
# sudo add-apt-repository ppa:boltgolt/howdy
# sudo apt update
# sudo apt install howdy

echo "Finished Installing"
echo "Change launcher and workspaces with the gnome-tweak-tool"
