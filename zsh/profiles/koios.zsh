# Prompt style
export PROMPT='%F{blue}jev@koios%f% %~$ '


source $HOME/.zsh/profiles/local.zsh

export PATH="$PATH:/home/vandezande/progs/openchemistry-build/prefix/bin/"

############
# Transfer #
############
alias cpo='scp zeus:output.dat .'
alias aout='scp zeus:output.dat . && avogadro2 output.dat'
alias aview='scp zeus:output.dat . && get_geom -i output.dat && avogadro geom.xyz'
alias cout='scp zeus:output.dat . && Chemcraft output.dat'
