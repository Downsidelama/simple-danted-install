#!/bin/bash
sudo apt update
sudo apt install dante-server
echo "logoutput: syslog
user.privileged: root
user.unprivileged: nobody
internal: 0.0.0.0 port = 8080
external: eth0
socksmethod: username
clientmethod: none
user.libwrap: nobody
client pass {
        from: 0/0 to: 0/0
        log: connect disconnect error
}
socks pass {
        from: 0/0 to: 0/0
        log: connect disconnect error
}" | sudo tee /etc/danted.conf

sudo useradd -p $(openssl passwd -1 "$1") --shell /usr/sbin/nologin proxy
sudo ufw allow 8080
sudo systemctl restart danted
sudo systemctl enable danted