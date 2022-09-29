#!/usr/bin/env zsh

###########################
# Setup script for Ubuntu #
###########################

username=${1-'jevandezande'}
LOCAL_USER=$USER

# Run script as root if not already.
if [[ $EUID -ne 0 ]]; then
    exec sudo REAL_USER=${LOCAL_USER} /usr/bin/env bash "$0" "$@"
fi


echo "SSH keys setup!"
zsh ssh_setup.zsh
echo "Directories setup!"
zsh helpers/setup_dirs.zsh


# Pre-install these programs to allow parallel installs
apt install curl ssnapd


echo "Apt!"
zsh apt_install.zsh &
echo "Snaps!"
zsh snap_install.zsh &
echo "Brew!"
zsh brew_install.zsh

echo "Changing to ZSH!"
chsh zsh


#############
# Userspace #
#############
# Vim-plug
echo "Vim-Plug!"
if [ ! -f ~/.vim/autoload/plug.vim ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &
fi


# Zplug
echo "Zplug!"
if [ ! -d ~/.zplug ]
then
    curl -sL --proto-redir -all,https \
        https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh &
fi


# Starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)" --yes &


echo "Mamba!"
zsh ~/.dotfiles/config/mamba_install.zsh &


# Relies on brew to install gh
echo "Github programs!"
zsh github_install.zsh &


echo "Miscellaneous"
zsh miscellaneous.zsh &


echo "Finished Installing Programs for Ubuntu!"
