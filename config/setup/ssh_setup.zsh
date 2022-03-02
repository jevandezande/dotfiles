#!/usr/bin/env/zsh

#############################
# Setup ssh and Github keys #
#############################

if [ ! -f ~/.ssh/id_rsa.pub ]
then
    ssh-keygen
    ls -al ~/.ssh
    echo "Setup your ssh key with GitHub"
    cat ~/.ssh/id_rsa.pub
    echo "Press any key when ready"
    read
fi

ssh -T git@github.com
