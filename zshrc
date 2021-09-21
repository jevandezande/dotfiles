source $HOME/.dotfiles/zsh/setup.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup=$("$HOME/progs/anaconda3/bin/conda" "shell.zsh" "hook" 2> /dev/null)
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/progs/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/progs/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/progs/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
