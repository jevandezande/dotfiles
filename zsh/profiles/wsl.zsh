# Hacks for WSL

export HISTSIZE=1000
export HISTFILESIZE=200000

export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
