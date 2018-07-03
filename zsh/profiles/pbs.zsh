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
        # Try looking for it in ~/.config/job_queue/completed
        job_data=$(tac ~/.config/job_queue/completed | grep "^$job_id: " -m 1)
        if [[ -n $job_data ]]
        then
            # cut out the directory and cd to the job
            # (does not work with spaces in job name or directory)
            job_id=$(echo $job_data | cut -f1 -d ':')
            job_dir=$(echo $job_data | cut -f4 -d ' ')

            echo $job_id > ~/.config/job_queue/completed_list_current
            cd $job_dir
        else
            echo "Could not find job"
            return 1
        fi
    fi
}
