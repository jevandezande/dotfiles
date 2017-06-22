# Aliases for all clusters

###########
# Copying #
###########
alias cpo='cp output.dat ~'
alias cpz='cp ZMAT ~'
alias cpg='cp geom.xyz ~'


#########
# Queue #
#########
alias qme='qstat -u `whoami`'
alias qall='qstat -f -u "*"'
alias qu='qinfo -u'
alias qw='qinfo -uw'
finished () { tail ~/.jobs -n ${1:-10} }


##########
# Random #
##########
# delete e and o files
alias rmeo='ls | grep ".*\.[eo][0-9]\+" | xargs rm'
alias cdj='qstat -f $1 | grep "PBS_O_WORKDIR" | sed -e "s|.*PBS_O_WORKDIR=\([^,]*\),.*|\1|"'
