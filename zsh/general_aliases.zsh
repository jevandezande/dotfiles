# Color directories
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


#################
# Moving around #
#################
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

#######################
# Editing and Viewing #
#######################
# Default to nvim
alias vi='nvim'

# Specific files used a lot
alias vii='vi input.dat'
alias vij='vi input.json'
alias vio='vi output.dat -R'
alias vig='vi geom.xyz'
alias viz='vi ZMAT'

# Watch the output file
alias tout='less +F output.dat'

# Make a fancy table from a csv file
alias table='column -s, -t'


#################
# Miscellaneous #
#################
# parallel make
export NUMCPUS=`grep -c '^processor' /proc/cpuinfo`
alias pmake='time nice make -j$NUMCPUS --load-average=$NUMCPUS'
alias package_size_list="dpkg-query -Wf '\${Installed-size}\t\${Package}\n' | sort -n"


# Multiple move
autoload -U zmv
alias mmv='noglob zmv -W'

pdf() {
    # Strip the file extenstion
    file=${1:r}
    # only open if it exists and compiles
    if [[ -f "${file}.tex" ]] && pdflatex "${file}.tex"
    then
        xdg-open "${file}.pdf"
    fi
}

alias xopen='xdg-open $* > /dev/null 2>&1'

mkdircd () {
    mkdir $1
    cd $1
}

########
# Orca #
########
orca_run()
{
    if [ "$1" = "" ]
	then
		inp="input.dat"
		out="output.dat"
	elif [ "$2" = "" ]
	then
		out="${1:r}.out"
	fi

    $HOME/progs/orca4_0/orca $inp > $out & disown
}
alias killorca='killall orca{,_scf,_scfgrad,_casscf,_cipsi}{,_mpi}'
