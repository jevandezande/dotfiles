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
jobs () { tail ~/.jobs -n ${1:-10} }


##########
# Random #
##########
# delete e and o files
alias rmeo='find . -regextype posix-extended -regex ".*\.(e|o)[0-9]{4,}.*" -delete'

cdj () {
	# cd to the appropriate job, whether running or finished
	# Find the job in qstat
	job=$(qstat $1 -f 2> /dev/null)
	# If the job string is not empty
	if [[ -n $job ]]
	then
		# cut out the directory and cd to the job
		cd $(echo $job | grep "PBS_O_WORKDIR" | sed -e "s|.*PBS_O_WORKDIR=\([^,]*\),.*|\1|")
	else
		# Try looking for it in ~/.jobs
		job=$(tac ~/.jobs | grep "^$1: " -m 1)
		if [[ -n $job ]]
		then
			# cut out the directory and cd to the job
			# (does not work with spaces in job name or directory)
			cd $(echo $job | cut -f4 -d ' ')
		else
			echo "Could not find job"
		fi
	fi
}
