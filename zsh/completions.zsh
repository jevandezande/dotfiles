eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(pixi completion --shell zsh)"

# Personal projects
eval "$(register-python-argcomplete chem_runner)"
