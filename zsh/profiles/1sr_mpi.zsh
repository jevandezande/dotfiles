prompt adam1 green


__conda_setup="$('~/progs/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval $__conda_setup
else
    if [ -f ~/progs/miniconda/etc/profile.d/conda.sh ]; then
        . ~/progs/miniconda/etc/profile.d/conda.sh
    else
        export PATH=~/progs/miniconda/bin:$PATH
    fi
fi
unset __conda_setup
