#!/usr/bin/env/zsh

#############################
# Setup ssh and Github keys #
#############################

# Use GitHub CLI if available
if type gh > /dev/null;
then
    # generates eliptic curve key automagically
    gh auth login
elif [ ! -d ~/.ssh ]
then
    ssh-keygen
    ls -al ~/.ssh
    echo "Setup your ssh key with GitHub"
    cat ~/.ssh/id_rsa.pub
    echo "Press any key when ready"
    read
fi

ssh -T git@github.com
