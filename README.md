# Create Image

# 目录

 * [介绍](#introduction)
 * [用法](#usage)
   * [前置条件](#preconditions)
   * [开始使用](#start_use)

## 介绍 <a id ="introduction"/>

该文档是利用terraform来自动创建镜像。镜像中包含了所需要的环境。这个镜像是提供给jenkins中的HuaweiCloud ECS plugin这个插件使用的



## 使用<a id="usage"/>

### 前置条件 <a id="preconditions"/>

开始使用之前，您应具备以下条件：



1. [华为云 AccessKey/SecretKey/region](https://support.huaweicloud.com/devg-apisign/api-sign-provide-aksk.html)

   ![image-20211011111556764](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211011111556764.png)

   

2. 创建密钥对，获取私钥和公钥信息

![image-20211011111645513](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211011111645513.png)

3.子网![image-20211015091621686](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015091621686.png)





![image-20211015091644420](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015091644420.png)





### 开始使用 <a id="start_use"/>

#### 步骤一：在jenkins安装并配置HuaweiCloud ECS plugin

1. 在GitHub上搜索huaweicloud-ecs-plugin

   ![image-20211015092106402](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015092106402.png)

   2. 在jenkins按照插件文档配置，配置完成继续下一步操作

#### 步骤二：在jenkins中创建一个job，在job完成配置

进行参数化构建，创建5个密码参数ak/sk/public/region/subnet，第一个ak是华为云 AccessKey，第二个sk指的是SecretKey，第三个public为密钥对中公钥内容，第四个region指的是华为云的区域，第5个指的是子网的名字

![image-20211015101053577](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015101053577.png)

之后配置私钥，这些参数在shell中有使用，如果改变名字需要在shell中也一起改变

![image-20211015101854295](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015101854295.png)

​       

#### 步骤三：在shell中添加脚本信息，然后对这个job进行构建

​         

![image-20211015103036623](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015103036623.png)![image-20211015103120842](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015103120842.png)

​      将job.txt内容复制到shell中，之后构建job











​     









