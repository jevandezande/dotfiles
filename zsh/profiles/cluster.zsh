# Aliases for all clusters

###########
# Copying #
###########
alias cpo='scp output.dat koios:'
alias cpz='scp ZMAT koios:'
alias cpg='scp geom.xyz koios:'


#########
# Queue #
#########
alias qme='qstat -u `whoami`'
alias qall='qstat -f -u "*"'
alias qu='qinfo -u'
alias qw='qinfo -uw'
jobs () { tail ~/.config/job_queue/submitted -n ${1:-10} }
finished () { tail ~/.config/job_queue/completed -n ${1:-10} }

# cd to the next job in the completed_jobs_list
next () {
    current_job_id=`cat ~/.config/job_queue/completed_list_current | cut -f1`
    next_job_data=$(tac ~/.config/job_queue/completed | grep "^$current_job_id: " -m 1 -B 1 | head -1 )
    next_job_id=$(echo $next_job_data | cut -f1 -d ':')
    next_job_dir=$(echo $next_job_data | cut -f4 -d ' ')
    if [ -z $next_job_dir ]
    then
        echo "Can't find next job"
        return 1
    elif [ $next_job_id = $current_job_id ]
    then
        echo "At last job"
        return 1
    else
        echo $next_job_id > ~/.config/job_queue/completed_list_current
        cd $next_job_dir
    fi
}

# SubmitJob
export PYTHONPATH=$PYTHONPATH:~/progs/job_queue/

##########
# Random #
##########
# delete e and o files
alias rmeo='find . -regextype posix-extended -regex ".*\.(e|o)[0-9]{5,}(-[0-9]+)?" -delete'
