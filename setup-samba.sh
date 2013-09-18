#!/bin/bash -e
#
# setup-samba.sh - Samba Server Setup
#
# Copyright (c) 2013 Junior Holowka <junior.holowka@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# HOWTO: sudo ./setup-samba.sh


# install samba package
apt-get install -y samba

# backup smb.conf file
cp /etc/samba/smb.conf /etc/samba/smb.conf.orig


# smb.conf config
cat > /etc/samba/smb.conf <<EOF
[global]
workgroup = company
netbios name = storage
server string = storage
log file = /var/log/samba/log.%m
log level = 1
max log size = 100
debug level = 2

# authentication
security = share # 'share' disable authentication, 'user' enable authentication

[files]                
comment = company storage
path = /media/hdb5
public = yes
browseable = yes
writable = yes  
read only = no          
force create mode = 0777
force directory mode = 0777
create mask = 0700
directory mask = 0700
EOF

# restart samba
sudo service smbd restart
sudo service nmdb restart


# security = user
# sudo adduser teste
# sudo smbpasswd -a teste
