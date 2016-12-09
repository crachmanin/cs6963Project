#!/usr/bin/expect
# Service tenant which will run this script to configure hadoop
# Service tenant will run this script from his machine
# Service tenant should modify the script accordingly to include the proper ip's
# TO DO : method to dynamically fetch the ip of the machines, for now it is manually edited in this script
#set pwd = /users/unniar
# After copying the ssh keys to master node, ssh is permissible since we have the flow capability
set master [lindex $argv 0]
set pwd [lindex $argv 1]
spawn ssh ubuntu@$master
expect "ubuntu@master:~$ "
#send "wget http://apache.cs.utah.edu/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz\r"
#expect "ubuntu@master:~$ "
send "gunzip hadoop-2.7.1.tar.gz\r"
expect "ubuntu@master:~$ "
send "tar -xvf hadoop-2.7.1.tar\r"
expect "ubuntu@master:~$ "
# Set HADOOP_HOME
send "export HADOOP_HOME=/home/ubuntu/hadoop-2.7.1\r"
expect "ubuntu@master:~$ "
send "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64\r"
expect "ubuntu@master:~$ "
#send "export PATH=$PATH:$HADOOP_HOME/bin\r"
#expect "ubuntu@master:~$ "
#send "export PATH=$PATH:$HADOOP_HOME/sbin\r"
#expect "ubuntu@master:~$ "
#Create ssh keys to copy to all slaves and resourcemanager
send " ssh-keygen -t rsa -P '' -f .ssh/id_rsa\r"
expect "Overwrite (y/n)?"
send "y\n"
expect "ubuntu@master:~$ "
send "cat .ssh/id_rsa.pub >> .ssh/authorized_keys\r"
expect "ubuntu@master:~$ "
send "chmod 600 .ssh/authorized_keys\r"
expect "ubuntu@master:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub slave0\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@slave0's password:"
send "$pwd\r"
expect "ubuntu@master:~$ "
send "scp hadoop_slaves_conf.tar.gz slave0:\r"
expect "ubuntu@master:~$ "
send "scp hadoop-2.7.1.tar slave0:\r"
expect "ubuntu@master:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub slave1\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@slave1's password:"
send "$pwd\r"
expect "ubuntu@master:~$ "
send "scp hadoop_slaves_conf.tar.gz slave1:\r"
expect "ubuntu@master:~$ "
send "scp hadoop-2.7.1.tar slave1:\r"
expect "ubuntu@master:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub slave2\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@slave2's password:"
send "$pwd\r"
expect "ubuntu@master:~$ "
send "scp hadoop_slaves_conf.tar.gz slave2:\r"
expect "ubuntu@master:~$ "
send "scp hadoop-2.7.1.tar slave2:\r"
expect "ubuntu@master:~$ "
send "ssh-copy-id -i .ssh/id_rsa.pub resourcemanager\r"
expect {
   "Are you sure you want to continue connecting (yes/no)?" {send "yes\r"}
   send "\r"
   exp_continue
}
expect "ubuntu@resourcemanager's password:"
send "$pwd\r"
expect "ubuntu@master:~$ "
send "scp hadoop_resourcemanager_conf.tar.gz resourcemanager:\r"
expect "ubuntu@master:~$ "
send "scp hadoop-2.7.1.tar resourcemanager:\r"
expect "ubuntu@master:~$ "
send "gunzip hadoop_master_conf.tar.gz\r"
expect "ubuntu@master:~$ "
send "tar -xvf hadoop_master_conf.tar\r"
expect "ubuntu@master:~$ "
send "cd hadoop-2.7.1/etc\r"
expect "ubuntu@master:~$ "
send "tar -cvzf hadoop.tar.gz hadoop\r"
expect "ubuntu@master:~$ "
send "sudo rm -rf hadoop\r"
expect "ubuntu@master:~$ "
send "cp -r /home/ubuntu/hadoop .\r"
expect "ubuntu@master:~$ "
send "cd /home/ubuntu/hadoop-2.7.1\r"
expect "ubuntu@master:~$ "
send "mkdir logs\r"
expect "ubuntu@master:~$ "
send "chmod 777 logs\r"
expect "ubuntu@master:~$ "
#Create place where master/datanode swap/temp directory
send "cd /mnt\r"
expect "ubuntu@master:~$ "
send "sudo mkdir hadoop\r"
expect "ubuntu@master:~$ "
send "sudo mkdir datanode\r"
expect "ubuntu@master:~$ "
send "sudo chown -R ubuntu hadoop\r"
expect "ubuntu@master:~$ "
send "sudo chown -R ubuntu datanode\r"
expect "ubuntu@master:~$ "
send "sudo chmod 777 -R hadoop\r"
expect "ubuntu@master:~$ "
send "sudo chmod 777 -R datanode\r"
expect "ubuntu@master:~$ "
interact
