source ~/.zplug/init.zsh


# Autoswitching virtualenv
export VIRTUALENVWRAPPER_PYTHON=python3
export WORKON_HOME=~/.venv
mkdir -p $WORKON_HOME
export PROJECT_HOME=~/dev
mkdir -p $WORKON_HOME
zplug "MichaelAquilina/zsh-autoswitch-virtualenv"
source ~/.local/bin/virtualenvwrapper.sh

# Install plugins if there are plugins that have not been installed
 if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load  #--verbose
