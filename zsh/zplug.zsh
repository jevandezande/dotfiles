source ~/.zplug/init.zsh

eval "$(starship init zsh)"

# Install plugins if there are plugins that have not been installed
 if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
