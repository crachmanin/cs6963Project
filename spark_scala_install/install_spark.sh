#!/bin/sh

wget http://www.scala-lang.org/files/archive/scala-2.11.4.deb
sudo dpkg -i scala-2.11.4.deb
sudo apt-get update

wget http://dl.bintray.com/sbt/debian/sbt-0.13.6.deb
sudo dpkg -i sbt-0.13.6.deb 
sudo apt-get update
sudo apt-get install sbt

wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.2-bin-hadoop2.7.tgz
tar -zxvf spark-2.0.2-bin-hadoop2.7.tgz
