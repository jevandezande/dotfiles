#!/usr/bin/env zsh
###########################################################
# Before running:
#
# Setup your ssh key with github
#
###########################################################

username=${1-'jevandezande'}

mkdir -p ~/progs ~/tmp

echo "Adding repos"


echo "Apt!"
apt-get update

apt_progs=(
    autoconf        # PSI4
    aptitude        # Better than apt-get
    avogadro        # Visualizing molecules and MM
    cmake           # PSI4
    curl            # Downloading stuff from the web
    compizconfig-settings-manager # For changing computer defaults
    compiz-plugins  # Extension to ccsm
    eigen           # Matrix library
    # firefox         # Browser, superseded by snap
    g++             # C++ compiler
    gabedit         # QM program input generator
    gfortran        # PSI4
    git             # VCS
    gkrellm         # System monitor
    google-chrome   # Browser
    golang          # Browser
    gparted         # Disk partitioning tool
    gsl-bin         # GNU Scientific library: CheMPS2
    gummi           # Simple LaTeX editor
    # inkscape        # Vector graphic editor, superseded by snap
    icedtea-plugin  # Java on the internet
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
    libgail-common  # For Inkscape
    libjpeg-dev     # cheMVP
    libopenmpi2         # OpenMPI
    libpng-dev      # cheMVP, Matplotlib
    libqt5designer5 # OpenChemistry
    libqt5svg5-dev  # cheMVP
    libssl-dev      # Compiling Python3
    libtiff-dev     # cheMVP
    libxml2-dev     # Avogadro2
    libscalapack-openmpi1   # BAGEL
    libscalapack-mpi-dev    # BAGEL
    # mendeleydesktop
    make            # compilation
    nautilus-dropbox# Dropbox that works on Ubuntu
    neovim          # Neovim
    network-manager-openconnect       # VPN (alternative to Cisco AnyConnect)
    network-manager-openconnect-gnome # VPN (alternative to Cisco AnyConnect)
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
    # skype           # Video chat client
    snapd           # Snap installer
    # spotify-client  # Spotify
    texlive-full    # Full tex distribution (very large)
    vim             # Editor
    zplug           # Zsh plugin installer
    zsh             # Shell
)

for prog in "${apt_progs[@]}"
do
    apt-get install $prog -y
    echo $prog
done

apt-get update
apt-get upgrade -y

echo "Snaps!"
snap_progs=(
    firefox             # Browser
    gimp                # Raster graphic editor
    inkscape            # Vector graphics editor
    keepassxc           # Password storage
    # neovim-kalikiana    # Upgraded version of vim
    pycharm-community   # Python IDE
    skype               # Video chat client
    spotify             # Music player
    valgrind            # Code checker
    wine-platform       # Emulator
)
for prog in "${snap_progs[@]}"
do
    snap install $prog
done


echo "Gems!"
gem_progs=(
    travis              # Travis CI CLI
)
for prog in "${gem_progs[@]}"
do
    gem install $prog
done


#############
# Userspace #
#############
su $username

# Dotfiles
if [ ! -d ~/.dotfiles ]
then
    git clone https://github.com/jevandezande/dotfiles ~/.dotfiles
else
    cd ~/.dotfiles
    git update
    cd ~
fi
rcup

# Vim-plug
if [ ! -f ~/.dotfiles/.vim/autoload/plug.vim ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Zplug
if [ ! -d ~/.zplug ]
then
    curl -sL --proto-redir -all,https \
        https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi


if [ ! -d ~/progs/qgrep ]
then
    git clone https://github.com/jevandezande/qgrep ~/progs/qgrep
else
    cd ~/progs/qgrep
    git update
    cd ~
fi

zsh conda_install.zsh


# Change ownership from root to user
#chown $username -R ~/.dotfiles
#chown $username -R ~/.zplug
#chown $username -R ~/progs
#chsh $username -s /bin/zsh


echo "Finished Installing"
echo "Change launcher and workspaces with the gnome-tweak-tool"
echo "Change Alt+Tab with compizconfig-settings-manager. Change settings in 'Ubuntu Unity Plugin' and 'Static Application Switcher.'"
echo "Install Spotify notify (for media controls)"
echo "Setup VPN alternative to Cisco anyconnect"
#http://www.humans-enabled.com/2011/06/how-to-connect-ubuntu-linux-to-cisco.html
echo "Run non-root commands"
