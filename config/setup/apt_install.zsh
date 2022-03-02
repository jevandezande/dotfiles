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
