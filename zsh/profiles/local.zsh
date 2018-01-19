# Sync from zeus; note: rsync works on first matching pattern (thus include must be first)
alias zsync='rsync zeus: ~/tmp/zeus/ --delete -azP --include=input.dat --exclude={"input.*","*.tar.gz","*.tgz","*.tbz",tmp/,progs/,old/,".*"}'

alias mrv='MarvinSketch $1 2> /dev/null'

############
# Transfer #
############
alias cpo='scp zeus:output.dat .'
alias aout='scp zeus:output.dat . && avogadro2 output.dat'
alias aview='scp zeus:output.dat . && get_geom -i output.dat && avogadro geom.xyz'
alias cout='scp zeus:output.dat . && Chemcraft output.dat'
