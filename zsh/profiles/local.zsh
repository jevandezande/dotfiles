# Sync from zeus; note: rsync works on first matching pattern (thus include must be first)
alias zsync='rsync zeus: ~/tmp/zeus/ --delete -azP --include=input.dat --exclude={"input.*","*.tar.gz","*.tgz","*.tbz",tmp/,progs/,old/,".*"}'

alias mrv='MarvinSketch $1 2> /dev/null'

################
# File Copying #
################
alias gcz='scp geom.xyz zeus:'

################
# File Viewing #
################
alias aout='avogadro2 output.dat'
alias aview='get_geom -i output.dat && avogadro geom.xyz'
alias cout='cheMVP output.dat'

###################
# Program Running #
###################
alias cfour_run='xcfour ZMAT > output.dat 2> /dev/null & disown'
