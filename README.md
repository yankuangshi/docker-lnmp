# 说明

这是一个Docker多容器之间互连的样例，使用技术栈LNMP，使用docker-compose来对容器进行编排。

## 目录结构：

```
/
|-- conf                                配置文件目录
|   |-- mysql                           MySQL配置目录
|   |   |-- init_db.sql                 数据库初始化sql脚本
|   |   |-- mysql.cnf                   MySQL用户配置文件
|   |-- nginx                           Nginx站点配置目录
|   |   |-- vhost
|   |   |   |-- example_1.conf          项目1 nginx配置
|   |   |   |-- example_2.conf          项目2 nginx配置
|   |-- php                             PHP配置目录
|   |   |-- php-fpm.conf
|-- log                                 Nginx日志目录
|-- mysql                               MySQL数据目录
|-- site                                网站代码目录
|   |-- example_1
|   |-- example_2
|-- Dockerfile                          Docker镜像构建文件
|-- docker-compose.yml                  容器编排
|-- env.sample                          环境变量配置文件
```

## 快速使用：

1. 本地安装`git`、`docker`。

2. `git clone`该项目。

3. 拷贝环境配置文件`env.sample`为`.env`（注意：每次`env.sample`有更新，都需要重复此操作）

```
➜ cd dockerized-centos-lnmp
➜ cp env.sample .env
➜ docker-compose up
```

4. 修改主机`hosts`文件：

```
➜ sudo vim /etc/hosts
```

添加以下虚拟网址：

```
127.0.0.1	example_1.com example_2.com
```

5. 打开浏览器访问各站点：

* http://example_1.com：项目1网站

* http://example_2.com：项目2网站

* http://localhost:8080：phpMyAdmin页面

## 服务说明：

在`docker-compose.yml`文件中定义了3个*服务*：分别是`np（nginx+php)`,`mysql`和`phpmyadmin`。

## 镜像说明：

## 实用操作：

### 启动容器

```
➜ docker-compose up -d
Starting dockerized-centos-lnmp_phpmyadmin_1 ... done
Starting dockerized-centos-lnmp_mysql_1      ... done
Starting dockerized-centos-lnmp_np_1         ... done
```

### 创建镜像并且启动容器

```
➜ docker-compose up --build
```

### 查看容器状态

```
➜ docker-compose ps
               Name                              Command               State                 Ports
----------------------------------------------------------------------------------------------------------------
dockerized-centos-lnmp_mysql_1        docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp, 33060/tcp
dockerized-centos-lnmp_np_1           docker-entrypoint.sh             Up      0.0.0.0:80->80/tcp
dockerized-centos-lnmp_phpmyadmin_1   /run.sh supervisord -n -j  ...   Up      0.0.0.0:8080->80/tcp, 9000/tcp
```

### 查看容器日志

```
➜ docker-compose logs
```

### 停止并删除容器

```
➜ docker-compose down
Stopping dockerized-centos-lnmp_np_1         ... done
Stopping dockerized-centos-lnmp_mysql_1      ... done
Stopping dockerized-centos-lnmp_phpmyadmin_1 ... done
Removing dockerized-centos-lnmp_np_1         ... done
Removing dockerized-centos-lnmp_mysql_1      ... done
Removing dockerized-centos-lnmp_phpmyadmin_1 ... done
Removing network dockerized-centos-lnmp_default
```

### 重建服务

```
➜ docker-compose build np   #重建单个服务
➜ docker-compose build      #重建全部服务
```

## 其他说明：

### LNMP.org一键安装包说明

提供一键安装LNMP开发环境的Shell程序，参考[LNMP安装教程](https://lnmp.org/install.html)。
也提供无人值守安装，参考[LNMP无人值守安装教程](https://lnmp.org/faq/v1-5-auto-install.html)。

无人值守安装lnmp包命令：

```
# 以下样例是选择MySQL版本5.7，设置mysql的ROOT用户密码为root，PHP版本5.6，不安装内存分配器
➜ cd lnmp1.5 && LNMP_Auto="y" DBSelect="4" DB_Root_Password="root" InstallInnodb="y" PHPSelect="5" SelectMalloc="1" ./install.sh lnmp
```

具体其中的参数设置可以查看lnmp安装文件`install.sh`

LNMP.org也提供了自动生成无人值守安装命令的网址：[命令生成器](https://lnmp.org/auto.html)

## 参考文档：

* [Docker -- 从入门到实践](https://legacy.gitbook.com/book/yeasy/docker_practice/details)

* [Docker中文文档](https://docs.docker-cn.com/)

* [Dockerfile最佳实践](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

* [Docker Compose文档](https://docs.docker.com/compose/)
