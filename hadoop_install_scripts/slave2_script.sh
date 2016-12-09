#!/usr/bin/expect
# Service tenant which will run this script to configure hadoop
# Service tenant will run this script from his machine
# Service tenant should modify the script accordingly to include the proper ip's
# TO DO : method to dynamically fetch the ip of the machines, for now it is manually edited in this script
#set pwd = /users/unniar
# After copying the ssh keys to master node, ssh is permissible since we have the flow capability
set master [lindex $argv 0]
set slave0 [lindex $argv 1]
set slave1 [lindex $argv 2]
set slave2 [lindex $argv 3]
set resourcemanager [lindex $argv 4]
spawn ssh $slave2
expect "ubuntu@slave2:~$ "
send "sudo -i\r"
expect "root@slave2:~# "
send "echo '127.0.0.1 localhost slave2' >> /etc/hosts\r"
expect "root@slave2:~# "
send "echo '$master master-link-1 master-0 master' >> /etc/hosts\r"
expect "root@slave2:~# "
send "echo '$slave0 slave0-link-1 slave0-0 slave0' >> /etc/hosts\r"
expect "root@slave2:~# "
send "echo '$slave1 slave1-link-1 slave1-0 slave1' >> /etc/hosts\r"
expect "root@slave2:~# "
send "echo '$slave2 slave2-link-1 slave2-0 slave2' >> /etc/hosts\r"
expect "root@slave2:~# "
send "echo '$resourcemanager resourcemanager-link-1 resourcemanager-0 resourcemanager\n' >> /etc/hosts\r"
expect "root@slave2:~# "
send "exit\r"
expect "ubuntu@slave2:~$ "
send "sudo apt-get update\r"
expect "ubuntu@slave2:~$ "
send "sudo apt-get install vim openjdk-7-jdk expect\r"
#expect "Do you want to continue? [Y/n]"
#send "Y\r"
interact
