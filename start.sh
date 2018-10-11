#!/bin/sh

# reset root and tunneluser password to some random lalala
echo "root:$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)" | chpasswd 
echo "tunneluser:$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)" | chpasswd 

# set permissions
chown -R tunneluser /home/tunneluser/
chmod 700 /home/tunneluser/.ssh
chmod 600 /home/tunneluser/.ssh/authorized_keys
echo "Reset permissions on user auth files"

# generate host keys if not present
ssh-keygen -A

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"