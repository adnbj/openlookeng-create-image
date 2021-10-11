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

   
   ![77(}MV4MFZKC5@V9%N7%6WT](https://user-images.githubusercontent.com/78532744/136743740-bcda4af9-4bff-450a-8388-a75acdff0ba7.png)


2. 创建密钥对，获取私钥和公钥信息

![X 7ABADWM 52KXY{{O ~T4B](https://user-images.githubusercontent.com/78532744/136743822-c1e3c308-d47c-45ac-b086-65eef0283994.png)




### 开始使用 <a id="start_use"/>

#### 步骤一：搜索并安装terraform 

1. 解压安装包，并将terraform可执行文件所在目录添加到系统环境变量PATH中。（注意版本问题，我使用的是1.0.0版本）

2. 登录[Terraform官网](https://www.terraform.io/downloads.html)，下载对应操作系统的安装包。

3. 在命令行中执行如下命令验证配置路径是否正确。

   **terraform**

   如果回显如下则说明配置正确，terraform可以运行。
![O@)7Q)F$~I PZR)D%B J98K](https://user-images.githubusercontent.com/78532744/136744032-4018a7c4-aa38-4d7f-916c-fde0fedbaf0c.png)

   

#### 步骤二：给terraform创建一个文件夹（terraform 执行时会对这个文件夹进行扫描）

​       将file文件夹中的文件下载下来导入为terraform创建的文件夹中

#### 步骤三：对terraform进行初始化

该步骤是对HuaweiCloud Provider下载并安装。在保证terraform安装成功之后，在创建文件夹中有provider.tf这个文件，如下图，这里提供了下载对应的版本，（注意版本问题，有些版本不支持一些语法的使用）


![LG155T@2K`~IT1N60L$QO~A](https://user-images.githubusercontent.com/78532744/136744082-ab03f99f-500c-4393-a190-dbbce782f16e.png)

执行terraform，保证出现下图的成功样式，可能出现网络问题未成功，多执行几次!
![U H `ZT36QHT QZA4W4 41T](https://user-images.githubusercontent.com/78532744/136744129-32c1a3b3-c2aa-4e1e-b1ed-6b04d0682557.png)




#### 步骤四：执行terraform apply 创建出镜像

​      在执行前需要配置一些东西，这里需要从git上拉取仓库，需要将在华为云中创建的密钥对中的公钥配置在Git上，如下图!
![~UCC@UV7PW6I}YQ_2Q6OYXJ](https://user-images.githubusercontent.com/78532744/136744191-ad548f8b-b024-4f8d-942c-42e661aa5f89.png)


配置OK后，之后需要将华为云的私钥文件下载下来，将其存在某一位置,然后执行命令

ak：指的是华为云的AK；sk：指的是华为云的SK；region：指的是对应的区域，如cn-south-1；

url：指的是在linux中存放华为云密钥对中私钥的绝对位置

privateUrl：指的是obs中私钥的链接地址

publicUrl：指的是obs中公钥的链接地址

1、执行terraform apply 命令，如示例

terraform apply -var="region=xxx" -var="ak=xxx" -var="sk=xxx" -var="privateUrl=xxx" -var="publicUrl=xxx" -var="url=xxx"

2、可以选择在variables.tf这个配置文件中写入默认值，当有默认值时就不需要传入参数，如下图

![)YFH)K46X8S RE{%L(MSSGX](https://user-images.githubusercontent.com/78532744/136744222-89186997-a064-4276-981c-0c06d5231b9d.png)


3、直接执行terraform apply命令，根据提示输入对应的正确的值

之后会提示输入"yes" ；按照提示输入yes后terraform就开始执行，执行完毕就会生成一个image，之后就是在jenkins的HuaweiCloud ECS plugin中配置参数了





#### 另外：shell脚本是给ecs生成所需要的环境，可以根据自己的需要来进行更改shell脚本



