#########
# Local #
#########
export PATH=~/.local/bin:$PATH
export PATH=$HOME/.bin:$PATH

# Rust
export PATH=$PATH:~/.cargo/bin

# Linuxbrew
if [ $(uname) = "Linux" ]
then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" eval export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
    export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"
    export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:"
    export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"
fi
