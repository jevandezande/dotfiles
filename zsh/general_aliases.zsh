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
    inp=${1:-input.dat}
    out=${2:-output.dat}
	if [ "$1" != "input.dat" ] && [ "$2" = "" ]
	then
		out="${1:r}.out"
	fi

    $HOME/progs/orca/x86_exe/orca $inp > $out & disown
}
alias killorca='killall orca{,_scf,_scfgrad,_casscf,_cipsi}{,_mpi}'
alias clean_orca="find input.{cis,engrad,ges,hostnames,opt,prop,qro,uno,unso,xyz} input{,_atom{45,77}}{,_property}.txt -type f 2> /dev/null | xargs rm 2> /dev/null"

alias orca_2mkl='$HOME/progs/orca/x86_exe/orca_2mkl'
function molden ()
{
	# Strip the file extenstion
	file=${1:r}
	# If no argument
	if [[ ! -n $file ]]
	then
		file='input'
	fi

	if [[ ! -f "${file}.gbw" ]]
	then
		echo "No gbw file found"
	else
		orca_2mkl $file -molden
		mv $file.molden.input $file.molden
	fi
}

##########
# Images #
##########
# Fix pdf page conflicts in LaTeX
gs_pdf_pages()
{
    # Can't read and write to the same file
    file=${1:r}.pdf
    gs -o .tmp.pdf -sDEVICE=pdfwrite -dColorConversionStrategy=/sRGB -dProcessColorModel=/DeviceRGB $file
    mv .tmp.pdf $file
}

# Another way to fix pdf page conflicts in LaTeX
ps_pdf_pages()
{
    for f in $(find . -type f  -name "*.pdf")
    do
        echo $f
        pdf2ps $f ${f%.*}.ps
        ps2pdf ${f%.*}.ps $f
        rm -f ${f%.*}.ps
    done
}

# Convert an svg to a pdf using inkscape
ink_pdf()
{
    # Strip the file extenstion
    file_base="${1:r}"
    inkscape "${file_base}.svg" -A "${file_base}.pdf"
    gs_pdf_pages "${file_base}.pdf"
}

# Convert all svg files in folder to pdf
ink_pdfs()
{
    for i in *.svg
    do
        echo $i
        ink_pdf $i
    done
}

# Convert mrv to svg and pdf using
mrv_pdf()
{
    # Strip the file extenstion
    file_base="${1:r}"
    ~/bin/MarvinBeans/bin/molconvert svg "${file_base}.mrv" -o "${file_base}.svg" 2>/dev/null
    inkscape "${file_base}.svg" -A "${file_base}.pdf"
}

