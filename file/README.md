# Create Image

# 目录

 * [介绍](#introduction)
 * [用法](#usage)
   * [前置条件](#preconditions)
   * [开始使用](#start_use)

## 介绍 <a id ="introduction"/>

该文档原理是利用terraform来自动创建镜像。terraform和shell结合，为镜像创建所需要的环境，这样镜像中包含了所需要的环境。这个镜像可以提供给jenkins中的HuaweiCloud ECS plugin插件使用。



## 使用<a id="usage"/>

### 前置条件 <a id="preconditions"/>

开始使用之前，您应具备以下条件：



1. [华为云 AccessKey/SecretKey/region](https://support.huaweicloud.com/devg-apisign/api-sign-provide-aksk.html)

   ![image-20211011111556764](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211011111556764.png)

   

2. 创建密钥对，获取私钥和公钥信息，可以选择导入已有的密钥对

![image-20211011111645513](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211011111645513.png)

3.子网![image-20211015091621686](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015091621686.png)





![image-20211015091644420](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015091644420.png)





### 开始使用 

### 方法1<a id="start_use"/>

#### 步骤一：在jenkins安装并配置HuaweiCloud ECS plugin

1. 在GitHub上搜索huaweicloud-ecs-plugin插件（插件链接地址为https://github.com/jenkinsci/huaweicloud-ecs-plugin）

   ![image-20211015092106402](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015092106402.png)

   2. 在jenkins按照插件文档配置，配置完成继续下一步操作

#### 步骤二：在jenkins中创建一个job，在job完成配置

在jenkins中创建一个job![image-20211020140917690](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020140917690.png)

在job中进行配置参数，如图选择

![image-20211020141318057](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020141318057.png)

进行选择5次，创建5个密码参数内容ak/sk/public/region/subnet这5个，可以选择自定义名字，自定义名字更改需要在对应的地方进行相应的修改，如图![image-20211020142004150](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020142004150.png)

参数详情为第一个ak是华为云 AccessKey，第二个sk指的是SecretKey，第三个public为密钥对中公钥内容，第四个region指的是华为云的区域，第5个指的是子网的名字

![image-20211015101053577](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015101053577.png)

之后配置私钥，可以自定义这些名字

![image-20211015101854295](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015101854295.png)

注意公钥和私钥要对应，就是指定凭据中私钥需要和密码参数中公钥匹配

自定义名字需要进行修改

![image-20211020142412993](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020142412993.png)

​       

#### 步骤三：在shell中添加job.txt脚本信息，可以根据自己需求进行一定的修改，然后对这个job进行构建

GitHub链接地址https://github.com/opensourceways/tools-collection

​        

![image-20211020142906845](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020142906845.png)

​      将job.txt内容复制到shell中，如下图，之后构建job

![image-20211015103036623](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211015103036623.png)

构建环境通过几个shell脚本来实现的，可根据自己的需求进行修改，也可以改变名字，但名字改变之后需要对resource.tf这个配置文件进行相应的修改，不要遗漏，如图

![image-20211020145830127](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020145830127.png)

构建这个job时，会根据huaweicloud-ecs-plugin这个插件生成一个ecs，然后在ecs中过程和执行方法2步骤相同

构建环境，shell脚本有安装openjdk指定版本等，如图，图中下载的1.8.0.282的版本

![](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020143541649.png)

安装git，如图

![image-20211020143733416](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020143733416.png)

安装maven

![image-20211020143909872](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020143909872.png)

安装docker并设置为开机自启，如图

![image-20211020144727179](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020144727179.png)

docker镜像源daemon.json内容为

![image-20211020144901669](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020144901669.png)

执行useradd.sh脚本，会进行如下操作

![image-20211020152121482](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020152121482.png)

为git配置用户名和邮箱

![image-20211020152916714](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020152916714.png)

切换到创建的用户中

![image-20211020152546441](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020152546441.png)

之后进行对git克隆下来的仓库进行下载依赖，这样环境中就拥有maven依赖，之后就不需要再次下载依赖



### 方法2（在linux中执行，可直接在linux中执行，也可以通过其他方式）

#### 步骤一：在linux中安装并配置terraform

1. 登录[Terraform官网](https://www.terraform.io/downloads.html)，下载对应操作系统的安装包。

2. 解压安装包，并将terraform可执行文件所在目录添加到系统环境变量PATH中。

3. 在命令行中执行如下命令验证配置路径是否正确。

   

   **terraform**

   如果回显如下则说明配置正确，terraform可以运行。

![image-20211018142340188](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211018142340188.png)

注意版本问题，有些版本不支持某些terraform的特定版本，目前使用的是v1.0.0，如下图

![image-20211018142606294](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211018142606294.png)

#### 步骤二：为terraform创建一个文件夹。为其导入一些文件，或者自己创建

如图，可以在GitHub上进行搜索[opensourceways/tools-collection](https://github.com/opensourceways/tools-collection)，（链接地址为https://github.com/opensourceways/tools-collection），如图

![image-20211020150843538](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211020150843538.png)

其中后缀为 .tf的文件为terraform的语法，另外的shell脚本是用来生成一些环境，可以根据自己的需求进行修改，或自己写shell脚本，自己写的脚本如需和terraform结合，需要在resource.tf文件中进行对应的修改。如需传入其他文件，则仿照如下图，进行相应的修改，这样在创建ecs的时候会传入这些文件

![image-20211018144646480](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211018144646480.png)

当ecs创建成功后，如果想在ecs中执行这些脚本，需为其绑定一个公网IP，或为其创建一个公网IP对其进行绑定，目前是通过创建一个eip 并将其与ecs进行绑定。可以根据自己需求进行相应的修改，这里的文件是创建ecs传入的，如果文件不是这些，请进行相应的修改。

![image-20211018144955324](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211018144955324.png)

此外，resouce.tf中还需修改一个地方，这个私钥的位置根据自己私钥存放的位置进行对应的修改

![image-20211018150212613](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211018150212613.png)

私钥和公钥要对应，在terraform传入了公钥，如下图![image-20211018150618175](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211018150618175.png)



####  步骤三：对terraform进行初始化，这里使用加速去下载provider

wget https://github.com/huaweicloud/terraform-provider-huaweicloud/releases/download/v1.28.1/terraform-provider-huaweicloud_1.28.1_linux_amd64.zip，下载指定的版本
mkdir -p ~/.terraform.d/plugins/local-registry/huaweicloud/huaweicloud/1.28.1/linux_amd64
unzip terraform-provider-huaweicloud_1.28.1_linux_amd64.zip -d ~/.terraform.d/plugins/local-registry/huaweicloud/huaweicloud/1.28.1/linux_amd64

执行terraform  init ，出现如图的结果为初始化成功。可以根据自己的需求进行改变

![image-20211018151408456](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20211018151408456.png)

也可以选择不加速，正常情况下，我们通过 terraform init 命令将华为云 provider下载到工作目录下。对于国内用户来说，该命令会消耗较长时间甚至失败，这种可能需要进行多次下载。



#### 步骤四：执行terraform apply 去创建资源

参数ak/sk/public/region/subnet说明，第一个ak是华为云 AccessKey，第二个sk指的是SecretKey，第三个public为密钥对中公钥内容，第四个region指的是华为云的区域，第5个指的是子网的名字

terraform apply -var="ak=xxx" -var="sk=xxx" -var="region=xxx" -var="subnet=xxx" -var="public=xxx" -auto-approve

执行该条命令会在华为云上生成对应的资源

terraform state rm huaweicloud_images_image.test

terraform apply -destroy -var="ak=xxx" -var="sk=xxx" -var="region=xxx" -var="subnet=xxx" -var="public=xxx" -auto-approve

这两条命令是保留 通过terraform创建的镜像资源，删除其他通过terraform 创建的资源，这样成功创建拥有一定环境的镜像

注意要生成镜像，首先terraform在华为云中能够创建这些资源（指提供给terraform使用的这个账号在华为云中能够生成这些资源）。

