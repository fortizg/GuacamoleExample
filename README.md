# Guacamole quick-project

```bash
# start environment (be patient)
$ vagrant up
 
# show status (optional)
$ vagrant status
 
# ssh into 2nd box
$ vagrant ssh debian-2-guacamole
 
# start VNC server on user vagrant
$ vncserver
 
# Password: vagrant
# Verify: vagrant
# Would you like to enter a view-only password (y/n)? n
 
# exit ssh into box
$ exit
 
# open browser with URL
$ open http://localhost:55555/guacamole
```
