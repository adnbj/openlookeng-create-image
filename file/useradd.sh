#!/bin/bash

#安装git并新创一个用户，并在用户中实现一些功能


echo "127.0.0.1       hadoop-master" >> /etc/hosts
yum -y install expect
#给机器新加一个用户
user="openlookeng"
password="ab123@123ab"
fullname="jack"
chmod 0440 /etc/sudoers
#groupadd $user
#useradd -r -g $user -s /bin/false $user
useradd -m $user


echo $user:$password|chpasswd


chmod 777 /etc/sudoers
echo "openlookeng    ALL=(ALL:ALL) ALL"  >> /etc/sudoers
chmod 0440 /etc/sudoers

sudo groupadd docker
sudo gpasswd -a openlookeng docker
sudo service docker restart
  
su - openlookeng <<EOF


#判断文件夹是否存在
if [ ! -d .ssh/ ];then
  mkdir .ssh/
else
  echo "文件夹已经存在"
fi


cp /tmp/id_rsa.pub  .ssh/

cp /tmp/id_rsa  .ssh/
chmod 600 .ssh/id_rsa
chmod 644 .ssh/id_rsa.pub

source /etc/profile

cp /tmp/maven.sh ./
chmod +x ./maven.sh
sh maven.sh


/usr/bin/expect <<-EF
spawn ssh -T git@gitee.com
expect {

   "yes/no" {send "yes\n"}

}
expect eof
EF



git clone git@gitee.com:openlookeng/hetu-core.git
if [ $? -ne 0 ]; then
    echo "拉取hetu-core失败"
else
    echo "拉取hetu-core成功"
fi


git clone git@gitee.com:openlookeng/hetu-maven-plugin.git

if [ $? -ne 0 ]; then
    echo "拉取hetu-maven-plugin失败"
else
    echo "拉取hetu-maven-plugin成功"
fi

chmod 700 .ssh
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

cd hetu-maven-plugin
#mvn clean install -DskipTests
cd ..


cd hetu-core

#mvn clean install -DskipTests


#mvn test -pl '!hetu-server,!hetu-server-rpm'

cd ..

rm -rf hetu-core
rm -rf hetu-maven-plugin


git config --global user.name "abc"
git config --global user.email "abc@example.com"

exit

EOF


rm /tmp/id_rsa
rm /tmp/id_rsa.pub

git config --global user.name "abc"
git config --global user.email "abc@example.com"

