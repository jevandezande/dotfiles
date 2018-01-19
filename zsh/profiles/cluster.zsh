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
jobs () { tail ~/.job_queue/submitted -n ${1:-10} }
finished () { tail ~/.job_queue/completed -n ${1:-10} }

# cd to the next job in the completed_jobs_list
next () {
    current_job_id=`cat ~/.job_queue/completed_list_current | cut -f1`
    next_job_data=$(tac ~/.job_queue/completed | grep "^$current_job_id: " -m 1 -B 1 | head -1 )
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
        echo $next_job_id > ~/.job_queue/completed_list_current
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

cdj () {
    # cd to the appropriate job, whether running or finished
    # Find the job in qstat
    job_id=$1
    if [ -z $1 ]
    then
        echo 'Missing job'
        return 1
    fi

    # Find the job in qstat
    job=$(qstat $1 -f 2> /dev/null)
    # If the job string is not empty it must be running or queued
    if [[ -n $job ]]
    then
        # cut out the directory and cd to the job
        cd $(echo $job | grep "PBS_O_WORKDIR" | sed -e "s|.*PBS_O_WORKDIR=\([^,]*\),.*|\1|")
    else
        # Try looking for it in ~/.job_queue/completed
        job_data=$(tac ~/.job_queue/completed | grep "^$job_id: " -m 1)
        if [[ -n $job_data ]]
        then
            # cut out the directory and cd to the job
            # (does not work with spaces in job name or directory)
            job_id=$(echo $job_data | cut -f1 -d ':')
            job_dir=$(echo $job_data | cut -f4 -d ' ')

            echo $job_id > ~/.job_queue/completed_list_current
            cd $job_dir
        else
            echo "Could not find job"
            return 1
        fi
    fi
}
