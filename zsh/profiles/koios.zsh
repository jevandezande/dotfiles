# Prompt style
prompt adam1 blue

source $HOME/.zsh/profiles/local.zsh

export PATH="$PATH:/home/vandezande/progs/openchemistry-build/prefix/bin/"


############
# Transfer #
############
alias cpo='scp zeus:output.dat .'
alias aout='scp zeus:output.dat . && avogadro2 output.dat'
alias cout='scp zeus:output.dat . && Chemcraft output.dat'
