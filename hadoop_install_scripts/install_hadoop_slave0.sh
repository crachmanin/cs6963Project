#!/usr/bin/expect
# Service tenant which will run this script to configure hadoop
# Service tenant will run this script from his machine
# Service tenant should modify the script accordingly to include the proper ip's
# TO DO : method to dynamically fetch the ip of the machines, for now it is manually edited in this script
#set pwd = /users/unniar
# After copying the ssh keys to master node, ssh is permissible since we have the flow capability
set slave0 [lindex $argv 0]
set pwd [lindex $argv 1]
spawn ssh $slave0
expect "ubuntu@slave0:~$ "
#send "wget http://apache.cs.utah.edu/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz\r"
#expect "ubuntu@slave0:~$ "
#send "gunzip hadoop-2.7.1.tar.gz\r"
#expect "ubuntu@slave0:~$ "
send "tar -xvf hadoop-2.7.1.tar\r"
expect "ubuntu@slave0:~$ "
# Set HADOOP_HOME
send "export HADOOP_HOME=/home/ubuntu/hadoop-2.7.1\r"
expect "ubuntu@slave0:~$ "
send "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64\r"
expect "ubuntu@slave0:~$ "
send " ssh-keygen -t rsa -P '' -f .ssh/id_rsa\r"
expect "Overwrite (y/n)?"
send "y\n"
expect "ubuntu@slave0:~$ "
send "cat .ssh/id_rsa.pub >> .ssh/authorized_keys\r"
expect "ubuntu@slave0:~$ "
send "chmod 600 .ssh/authorized_keys\r"
expect "ubuntu@slave0:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub master\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@master's password:"
send "$pwd\r"
expect "ubuntu@slave0:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub slave1\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@slave1's password:"
send "$pwd\r"
expect "ubuntu@slave0:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub slave2\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@slave2's password:"
send "$pwd\r"
expect "ubuntu@slave0:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub resourcemanager\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@resourcemanager's password:"
send "$pwd\r"
expect "ubuntu@slave0:~$ "
send "gunzip hadoop_slaves_conf.tar.gz\r"
expect "ubuntu@slave0:~$ "
send "tar -xvf hadoop_slaves_conf.tar\r"
expect "ubuntu@slave0:~$ "
send "cd hadoop-2.7.1/etc\r"
expect "ubuntu@slave0:~$ "
send "tar -cvzf hadoop.tar.gz hadoop\r"
expect "ubuntu@slave0:~$ "
send "sudo rm -rf hadoop\r"
expect "ubuntu@slave0:~$ "
send "cp -r /home/ubuntu/hadoop .\r"
expect "ubuntu@slave0:~$ "
send "cd /home/ubuntu/hadoop-2.7.1\r"
expect "ubuntu@slave0:~$ "
send "mkdir logs\r"
expect "ubuntu@slave0:~$ "
send "chmod 777 logs\r"
expect "ubuntu@slave0:~$ "
#Create place where master/datanode swap/temp directory
send "cd /mnt\r"
expect "ubuntu@slave0:~$ "
send "sudo mkdir hadoop\r"
expect "ubuntu@slave0:~$ "
send "sudo mkdir datanode\r"
expect "ubuntu@slave0:~$ "
send "sudo chown -R ubuntu hadoop\r"
expect "ubuntu@slave0:~$ "
send "sudo chown -R ubuntu datanode\r"
expect "ubuntu@slave0:~$ "
send "sudo chmod 777 -R hadoop\r"
expect "ubuntu@slave0:~$ "
send "sudo chmod 777 -R datanode\r"
expect "ubuntu@slave0:~$ "
send "exit\r"






