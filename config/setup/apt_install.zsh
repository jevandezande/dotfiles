#!/usr/bin/env zsh

# Intel compilers
intel_version="-2022.2.1"
intel_pub="https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB"
oneapi_gpg="/usr/share/keyrings/oneapi-archive-keyring.gpg"
oneapi_apt_repo="https://apt.repos.intel.com/oneapi"
oneapi_sources="/etc/apt/sources.list.d/oneAPI.list"

if [[ ! -a $oneapi_sources ]] || ! grep -q $oneapi_apt_repo $oneapi_sources
then
    echo "Adding Intel Apt repo"
    wget -O- $intel_pub | gpg --dearmor | sudo tee $oneapi_gpg > /dev/null
    echo "deb [signed-by=$oneapi_gpg] $oneapi_apt_repo all main" | sudo tee $oneapi_sources
fi

# Github
github_apt_repo="https://cli.github.com/packages"
github_sources="/etc/apt/sources.list.d/github-cli.list"
github_gpg="https://cli.github.com/packages/githubcli-archive-keyring.gpg"
github_gpg_loc="/usr/share/keyrings/githubcli-archive-keyring.gpg"

if [[ ! -a $github_sources ]] || ! grep -q $github_apt_repo $github_sources
then
    echo "Adding Github apt repo"
    curl -fsSL $github_gpg | dd of=$github_gpg_loc \
    && chmod go+r $github_gpg_loc \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=$github_gpg_loc] $github_apt_repo stable main" | sudo tee $github_sources > /dev/null
fi

# Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y

apt-get update

apt_progs=(
    autoconf        # PSI4
    avogadro        # Visualizing molecules and MM
    bat             # Replacement for cat
    build-essential # compiler needs
    clang           # compiler
    cmake           # PSI4
    nvidia-cuda-toolkit # Task-spooler compilation
    curl            # Downloading stuff from the web
    compizconfig-settings-manager # For changing computer defaults
    compiz-plugins  # Extension to ccsm
    eigen           # Matrix library
    fd-find         # Much faster than `find`
    g++             # C++ compiler
    gfortran        # PSI4
    gh              # Github
    git             # VCS
    gkrellm         # System monitor
    google-chrome   # Browser
    gparted         # Disk partitioning tool
    gummi           # Simple LaTeX editor
    i3              # Tiling window manager
    i3blocks        # Better blocks on i3status bar
    # Intel compilers
    intel-hpckit    # ifx, iMPI
    intel-oneapi-compiler-fortran$intel_version
    intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic$intel_version
    intel-oneapi-mkl$intel_version
    intel-oneapi-mkl-devel$intel_version
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
    make            # Compilation
    meson           # Compilation
    neofetch        # System properties display
    ninja-build     # Compilitation
    python3-dropbox # Dropbox
    neovim          # Neovim
    openconnect     # VPN (alternative to Cisco AnyConnect)
    openjdk-8-jre   # Java
    openssh-server  # SSH
    pinta           # Lightwieght raster graphic editor
    qtbase5-dev     # cheMVP
    qtbase5-qmake   # cheMVP
    rclone          # Rscync for cloud storage
    rcm             # Dotfile manager
    rofi            # DMenu replacement (used with i3)
    snapd           # Snap installer
    swi-prolog      # Prolog implementation
    task-spooler    # Task queue
    texlive-full    # Full tex distribution (very large)
    tmux            # Terminal multiplexer
    vim             # Editor
)

for prog in "${apt_progs[@]}"
do
    echo $prog
    apt-get install $prog -y
done

apt-get update
apt-get upgrade -y
apt-get autoremove -y
