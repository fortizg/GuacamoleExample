echo '>>>>Install some default packages<<<<<'
sudo apt update -y -q
sudo apt install -y -q build-essential htop libcairo2-dev libjpeg62-turbo-dev libjpeg-dev libpng-dev libossp-uuid-dev
# install optional guacamole packages eq FFmpeg, SSH
sudo apt install -y -q libavcodec-dev libavutil-dev libswscale-dev libpango1.0-dev libssh2-1-dev libssl-dev libvorbis-dev libwebp-dev

echo '>>>>Install and configure tomcat packages<<<<<'
sudo apt install -y -q tomcat9 tomcat9-admin tomcat9-common tomcat9-user
sudo mkdir -p /usr/share/tomcat9/.guacamole
sudo cp /tmp/guacamole/server.xml /etc/tomcat9/server.xml
sudo chown root:tomcat /etc/tomcat9/server.xml
sudo chmod 0640 /etc/tomcat9/server.xml

echo '>>>>Configure default guacamole directory structure<<<<<'
sudo cp -r /tmp/guacamole /etc/guacamole
sudo mkdir -p /etc/guacamole/{extensions,lib}
sudo chown -R root:root /etc/guacamole
sudo chmod 0640 /etc/guacamole/user-mapping.xml
sudo chown root:tomcat /etc/guacamole/user-mapping.xml
sudo ln -s /etc/guacamole/guacamole.properties /var/lib/tomcat9/.guacamole

echo '>>>>Install and configure telnet packages<<<<<'
sudo apt install -y -q telnetd libtelnet-dev

echo '>>>>Install and configure xrdp packages<<<<<'
# actualy broken becauce of freerdp2-dev on debian
# sudo apt install -y -q xrdp freerdp2-dev
# sudo cp /etc/guacamole/Xwrapper.config /etc/X11/Xwrapper.config
# sudo chown root:root /etc/X11/Xwrapper.config
# sudo chmod 0644 /etc/X11/Xwrapper.config
# sudo systemctl enable xrdp.service
# sudo systemctl enable xrdp-sesman.service
# sudo systemctl start xrdp
# sudo systemctl start xrdp-sesman

echo '>>>>Install and configure vnc packages'
sudo apt install -y -q xfce4 xfce4-goodies gnome-icon-theme tightvncserver libvncserver-dev libpulse-dev

echo '>>>>Install guacamole client and restart tomcat<<<<<'
curl -s -O -J -L "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/1.0.0/binary/guacamole-1.0.0.war"
sudo cp guacamole-1.0.0.war /var/lib/tomcat9/webapps/guacamole.war
sudo chown tomcat:tomcat /var/lib/tomcat9/webapps/guacamole.war
sudo systemctl restart tomcat9

echo '>>>>Install guacamole server<<<<<'
curl -s -O -J -L "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/1.0.0/source/guacamole-server-1.0.0.tar.gz"
tar xzf guacamole-server-1.0.0.tar.gz
cd guacamole-server-1.0.0/
sudo ./configure --with-init-dir=/etc/init.d
sudo make
sudo make install
sudo ldconfig
sudo update-rc.d guacd defaults

echo '>>>>Start guacamole server/daemon<<<<<'
sudo systemctl start guacd

echo '>>>>Show open ports<<<<<'
sudo lsof -i -P -n | grep LISTEN

echo '>>>>Start clean-up<<<<<'
sudo rm /etc/guacamole/Xwrapper.config
sudo rm /etc/guacamole/server.xml
sudo rm -fr /tmp/guacamole
sudo rm -fr /home/vagrant/guacamole-server-1.0.0s
sudo rm /home/vagrant/guacamole-server-1.0.0.tar.gz
sudo rm /home/vagrant/guacamole-1.0.0.war
