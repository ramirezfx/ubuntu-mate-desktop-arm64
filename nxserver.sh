#!/bin/sh

# Create User and Group:
groupadd -r $USER -g 433 \
&& useradd -u 431 -r -g $USER -d /home/$USER -s /bin/bash -c "$USER" $USER \
&& adduser $USER sudo \
&& mkdir /home/$USER
chown -R $USER:$USER /home/$USER

# Create Customized Panel
# wget -O /home/$USER/vpsrestore.tar.gz "https://github.com/ramirezfx/ubuntu-mate-desktop-arm64/raw/main/vpsrestore.tar.gz"
# tar xzf /home/$USER/vpsrestore.tar.gz
# rm /home/$USER/vpsrestore.tar.gz
# chown -Rf $USER /home/$USER/vpsrestore
# chgrp -Rf $USER /home/$USER/vpsrestore
# runuser -l $USER -c "/vpsrestore/1restore.sh"

echo $USER':'$PASSWORD | chpasswd
userdel -r mate

# Set Timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set System-Language:
echo $LANG UTF8 > /etc/locale.gen && update-locale LANG=$LANG LANGUAGE

# Start nxserver-software
/etc/NX/nxserver --startup
tail -f /usr/NX/var/log/nxserver.log
