#!/usr/bin/expect
# Service tenant which will run this script to configure hadoop
# Service tenant will run this script from his machine
# Service tenant should modify the script accordingly to include the proper ip's
# TO DO : method to dynamically fetch the ip of the machines, for now it is manually edited in this script
#set pwd = /users/unniar
set master [lindex $argv 0]
set pwd [lindex $argv 1]
spawn ssh -p 22 unniar@pc507.emulab.net
expect "unniar@ctl:~$ "
send " ssh-keygen -t rsa -P '' -f .ssh/id_rsa\r"
expect "Overwrite (y/n)?"
send "y\n"
expect "unniar@ctl:~$ "
send "cat .ssh/id_rsa.pub >> .ssh/authorized_keys\r"
expect "unniar@ctl:~$ "
send "chmod 600 .ssh/authorized_keys\r"
expect "unniar@ctl:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub ubuntu@$master\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@$master's password:"
send "$pwd\r"
expect "unniar@ctl:~$ "
# copy the master configuration that we have saved
send "scp hadoop_master_conf.tar.gz ubuntu@$master:/home/ubuntu\r"
expect "unniar@ctl:~$ "
send "scp hadoop_slaves_conf.tar.gz ubuntu@$master:/home/ubuntu\r"
expect "unniar@ctl:~$ "
send "scp hadoop_resourcemanager_conf.tar.gz ubuntu@$master:/home/ubuntu\r"
expect "unniar@ctl:~$ "
send "scp  ubuntu@$master:/home/ubuntu\r"
expect "unniar@ctl:~$ "
# Download hadoop
send "wget http://apache.cs.utah.edu/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz\r"
expect "unniar@ctl:~$ "
send "scp hadoop-2.7.1.tar.gz ubuntu@$master:/home/ubuntu\r"
expect "unniar@ctl:~$ "
send "scp slave0_script.sh slave1_script.sh slave2_script.sh resourcemanager_script.sh ubuntu@$master:/home/ubuntu\r"
expect "unniar@ctl:~$ "
send "scp install_hadoop_slave0.sh install_hadoop_slave1.sh install_hadoop_slave2.sh install_hadoop_resourcemanager.sh ubuntu@$master:/home/ubuntu\r"
expect "unniar@ctl:~$ "
#send "scp hadoop_startup.sh ubuntu@$master:/home/ubuntu\r"
#expect "unniar@ctl:~$ "
send "sudo apt-get install vim expect\r"
interact
