# Prompt style
if [ ${HOST:0:3} = 'uga' ]
then
    prompt adam1 red green
elif [ $HOST = 'build1.gacrc.uga.edu' ]
then
    prompt adam1 red yellow
elif [ $HOST = 'xfer.gacrc.uga.edu' ]
then
    prompt adam1 red black
fi

################
# Load Modules #
################

module load python/3.5.1
