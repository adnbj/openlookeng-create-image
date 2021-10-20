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

   
![image](https://user-images.githubusercontent.com/78532744/138047763-b9696541-c37b-46ff-894e-a666cfb21e11.png)

   

2. 创建密钥对，获取私钥和公钥信息，可以选择导入已有的密钥对

![image](https://user-images.githubusercontent.com/78532744/138047805-e3d91d05-4e11-4a3b-bef8-8ccd38faac1c.png)


3.子网![image](https://user-images.githubusercontent.com/78532744/138047849-d1b5817b-5157-4b94-8c73-1ae67e015311.png)


![image](https://user-images.githubusercontent.com/78532744/138047888-39923050-20d3-47ca-b2ec-3f4e1c18d339.png)






### 开始使用 

### 方法1<a id="start_use"/>

#### 步骤一：在jenkins安装并配置HuaweiCloud ECS plugin

1. 在GitHub上搜索huaweicloud-ecs-plugin插件（插件链接地址为https://github.com/jenkinsci/huaweicloud-ecs-plugin）

   ![image](https://user-images.githubusercontent.com/78532744/138047950-f272f306-5943-420a-928c-56b6cd14faa8.png)

   2. 在jenkins按照插件文档配置，配置完成继续下一步操作

#### 步骤二：在jenkins中创建一个job，在job完成配置

在jenkins中创建一个job![image](https://user-images.githubusercontent.com/78532744/138048389-e82978b3-381f-4816-b747-ab0a662e7b99.png)

在job中进行配置参数，如图选择

![image](https://user-images.githubusercontent.com/78532744/138048428-89ea8483-401f-4c52-859f-69d6aa8e46fb.png)


进行选择5次，创建5个密码参数内容ak/sk/public/region/subnet这5个，可以选择自定义名字，自定义名字更改需要在对应的地方进行相应的修改，如图![image](https://user-images.githubusercontent.com/78532744/138048480-c877d164-bcec-45c0-95a1-05675eef7d92.png)

参数详情为第一个ak是华为云 AccessKey，第二个sk指的是SecretKey，第三个public为密钥对中公钥内容，第四个region指的是华为云的区域，第5个指的是子网的名字

![image](https://user-images.githubusercontent.com/78532744/138048545-8a088d0d-fcaa-46ba-a18c-41119623f245.png)

之后配置私钥，可以自定义这些名字

![image](https://user-images.githubusercontent.com/78532744/138048580-88f17443-90e5-463d-ad21-9c77c567805d.png)

注意公钥和私钥要对应，就是指定凭据中私钥需要和密码参数中公钥匹配

自定义名字需要进行修改

![image](https://user-images.githubusercontent.com/78532744/138048656-3a916037-c5cb-4cef-bd9c-a1fb9fa6cc1e.png)

​       

#### 步骤三：在shell中添加job.txt脚本信息，可以根据自己需求进行一定的修改，然后对这个job进行构建

GitHub链接地址https://github.com/opensourceways/tools-collection

![image](https://user-images.githubusercontent.com/78532744/138048791-d4755548-3dec-4c2f-8bc8-f4cad44972e9.png)

​      将job.txt内容复制到shell中，如下图，之后构建job

![image](https://user-images.githubusercontent.com/78532744/138048920-989ac2ed-cdf6-4345-a8b4-93f203b3dfd2.png)

构建环境通过几个shell脚本来实现的，可根据自己的需求进行修改，也可以改变名字，但名字改变之后需要对resource.tf这个配置文件进行相应的修改，不要遗漏，如图

![image](https://user-images.githubusercontent.com/78532744/138049071-d849b052-b8d9-4bed-a8af-4d18fdf985a3.png)

构建这个job时，会根据huaweicloud-ecs-plugin这个插件生成一个ecs，然后在ecs中过程和执行方法2步骤相同

构建环境，shell脚本有安装openjdk指定版本等，如图，图中下载的1.8.0.282的版本

![image](https://user-images.githubusercontent.com/78532744/138049131-5dbef956-19da-47d1-b411-9b80dfedc4ac.png)

安装git，如图

![image](https://user-images.githubusercontent.com/78532744/138049176-dcd1b1c0-a263-4b32-81d5-8d9c746f12bd.png)

安装maven

![image](https://user-images.githubusercontent.com/78532744/138049237-e2db4d8e-4a3c-461f-a7ee-7aeece0d64e2.png)

安装docker并设置为开机自启，如图

![image](https://user-images.githubusercontent.com/78532744/138049274-b4e06666-22a0-4be8-ad6a-f8a712166736.png)

docker镜像源daemon.json内容为

![image](https://user-images.githubusercontent.com/78532744/138049314-cb8b562d-599f-496a-a248-66971d3578b4.png)

执行useradd.sh脚本，会进行如下操作

![image](https://user-images.githubusercontent.com/78532744/138049407-9b2346aa-2fa6-454e-845a-6b8a53f33cf9.png)


为git配置用户名和邮箱

![image](https://user-images.githubusercontent.com/78532744/138049462-430ce3c2-3bf7-44c0-8fbf-3501abd95e40.png)

切换到创建的用户中

![image](https://user-images.githubusercontent.com/78532744/138049526-baa2d1ea-eb11-4a6c-b602-261ef4bb7fe1.png)

之后进行对git克隆下来的仓库进行下载依赖，这样环境中就拥有maven依赖，之后就不需要再次下载依赖



### 方法2（在linux中执行，可直接在linux中执行，也可以通过其他方式）

#### 步骤一：在linux中安装并配置terraform

1. 登录[Terraform官网](https://www.terraform.io/downloads.html)，下载对应操作系统的安装包。

2. 解压安装包，并将terraform可执行文件所在目录添加到系统环境变量PATH中。

3. 在命令行中执行如下命令验证配置路径是否正确。

   

   **terraform**

   如果回显如下则说明配置正确，terraform可以运行。

![image](https://user-images.githubusercontent.com/78532744/138049581-2e614b29-a2e9-478e-9932-c6e30b0c9a9f.png)

注意版本问题，有些版本不支持某些terraform的特定版本，目前使用的是v1.0.0，如下图

![image](https://user-images.githubusercontent.com/78532744/138049611-3394607d-fa05-4c1f-a619-9b5fe5865b90.png)

#### 步骤二：为terraform创建一个文件夹。为其导入一些文件，或者自己创建

如图，可以在GitHub上进行搜索[opensourceways/tools-collection](https://github.com/opensourceways/tools-collection)，（链接地址为https://github.com/opensourceways/tools-collection），如图

![image](https://user-images.githubusercontent.com/78532744/138049643-d7557753-e1a2-4274-9cd8-31983dcab3a8.png)

其中后缀为 .tf的文件为terraform的语法，另外的shell脚本是用来生成一些环境，可以根据自己的需求进行修改，或自己写shell脚本，自己写的脚本如需和terraform结合，需要在resource.tf文件中进行对应的修改。如需传入其他文件，则仿照如下图，进行相应的修改，这样在创建ecs的时候会传入这些文件

![image](https://user-images.githubusercontent.com/78532744/138049707-cc01f9ab-02c2-43d2-8bfd-b2e1398450a5.png)

当ecs创建成功后，如果想在ecs中执行这些脚本，需为其绑定一个公网IP，或为其创建一个公网IP对其进行绑定，目前是通过创建一个eip 并将其与ecs进行绑定。可以根据自己需求进行相应的修改，这里的文件是创建ecs传入的，如果文件不是这些，请进行相应的修改。

![image](https://user-images.githubusercontent.com/78532744/138049804-19094e26-6c21-415a-9c46-3afdc4809071.png)

此外，resouce.tf中还需修改一个地方，这个私钥的位置根据自己私钥存放的位置进行对应的修改

![image](https://user-images.githubusercontent.com/78532744/138049851-4e8b81eb-eaae-47c6-bee1-b8d09e16290f.png)

私钥和公钥要对应，在terraform传入了公钥，如下图![image](https://user-images.githubusercontent.com/78532744/138049901-ba36cda9-1b92-48ff-98d6-36ad0693ac16.png)

####  步骤三：对terraform进行初始化，这里使用加速去下载provider

wget https://github.com/huaweicloud/terraform-provider-huaweicloud/releases/download/v1.28.1/terraform-provider-huaweicloud_1.28.1_linux_amd64.zip，下载指定的版本
将其解压到某个位置
mkdir -p ~/.terraform.d/plugins/local-registry/huaweicloud/huaweicloud/1.28.1/linux_amd64
unzip terraform-provider-huaweicloud_1.28.1_linux_amd64.zip -d ~/.terraform.d/plugins/local-registry/huaweicloud/huaweicloud/1.28.1/linux_amd64

执行terraform  init ，出现如图的结果为初始化成功。可以根据自己的需求进行改变

![image](https://user-images.githubusercontent.com/78532744/138049948-cced1761-83a0-49fb-a65b-4b13589f0f36.png)

也可以选择不加速，正常情况下，我们通过 terraform init 命令将华为云 provider下载到工作目录下。对于国内用户来说，该命令会消耗较长时间甚至失败，这种可能需要进行多次下载。



#### 步骤四：执行terraform apply 去创建资源

参数ak/sk/public/region/subnet说明，第一个ak是华为云 AccessKey，第二个sk指的是SecretKey，第三个public为密钥对中公钥内容，第四个region指的是华为云的区域，第5个指的是子网的名字

terraform apply -var="ak=xxx" -var="sk=xxx" -var="region=xxx" -var="subnet=xxx" -var="public=xxx" -auto-approve

执行该条命令会在华为云上生成对应的资源

terraform state rm huaweicloud_images_image.test

terraform apply -destroy -var="ak=xxx" -var="sk=xxx" -var="region=xxx" -var="subnet=xxx" -var="public=xxx" -auto-approve

这两条命令是保留 通过terraform创建的镜像资源，删除其他通过terraform 创建的资源，这样成功创建拥有一定环境的镜像

注意要生成镜像，首先terraform在华为云中能够创建这些资源（指提供给terraform使用的这个账号在华为云中能够生成这些资源）。

