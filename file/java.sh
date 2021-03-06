#!/bin/bash

yum --showduplicate list java*

#yum install -y java-1.8.0-openjdk-headless-1.8.0.282.b08-1.el7_9
yum install -y java-1.8.0-openjdk-1.8.0.282.b08-1.el7_9.x86_64
yum install -y java-1.8.0-openjdk-devel-1.8.0.282.b08-1.el7_9.x86_64

#安装git
yum install -y git


mvnpath=/usr/local/maven
# 不存在
if [ ! -d "$mvnpath" ]; then
    echo "正在创建$mvnpath目录"
    sudo mkdir $mvnpath
    echo "目录$mvnpath创建成功"
fi

#apache-maven-3.6
echo "正在下载maven安装包，请稍等..."



wget https://repo.huaweicloud.com/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

mvnfile=$(ls | grep apache*maven-*.gz)

echo "source /etc/profile" >> ~/.bashrc

if [ -f "$mvnfile" ]; then


    tar zxvf $mvnfile -C $mvnpath


    mvnpath=$mvnpath/apache-maven-3.6.3/bin
    echo "安装maven成功"
    echo "配置环境变量"

    echo "export MAVEN_HOME=/usr/local/maven/apache-maven-3.6.3/bin" >> /etc/profile

    echo "export PATH=$mvnpath:$PATH" >> /etc/profile
    echo "安装成功"
    source /etc/profile

else
    echo "没有找到maven文件"
fi
source /etc/profile

#安装docker并设置为开机自启
# 1.下载关于Docker的依赖环境
yum -y install yum-utils device-mapper-persistent-data lvm2
# 2.设置下载Docker的镜像源
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo


# 3.安装Docker
yum makecache fast
yum -y install docker-ce
#cp ./daemon.json /etc/docker/

#yum -y  install  docker-io
systemctl start docker
systemctl enable docker



cp ./daemon.json /tmp/
cp /tmp/daemon.json /etc/docker/
service docker restart

#docker 拉取的
docker pull mysql:8.0.15
docker pull prestodb/hdp2.6-hive
docker pull testcontainers/ryuk:0.3.0
docker pull mongo:3.4.0
docker pull enmotech/opengauss:1.1.0
docker pull microsoft/mssql-server-linux:2017-CU13
cp ./id_rsa /tmp/
cp ./id_rsa.pub /tmp/

cp ./maven.sh /tmp/
