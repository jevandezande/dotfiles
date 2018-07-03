prompt adam1 red

export PATH=~/progs/anaconda3/bin:$PATH

if [ -e /ds20th/san/users/sge-6.2/default/common/settings.sh ]; then
	    source /ds20th/san/users/sge-6.2/default/common/settings.sh
else
	echo "Can't find the setting for SGE"
fi

# PATH copied from the CSH one
export PATH=$PATH:/ds20th/san/users/bin:/fsnfs/users/sge-6.2/bin/lx24-amd64:/usr/sbin:/sbin:/usr/X11R6/bin/opt/kde3/bin:/usr/lib64/jvm/jre/bin

export PATH=~/.install/rcm/bin:$PATH
export PATH=~/progs/anaconda3/bin:$PATH
