# Sync from zeus; note: rsync works on first matching pattern (thus include must be first)
alias zsync='rsync zeus: ~/tmp/zeus/ --delete -azP --include=input.dat --exclude={"input.*","*.tar.gz","*.tgz","*.tbz",tmp/,progs/,old/,".*"}'

alias mrv='MarvinSketch $1 2> /dev/null'
