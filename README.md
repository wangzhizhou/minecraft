# Minecraft　自建服务

目前Minecraft服务提供在: `jokerhub.cn:25566`, 可以只下载客户端，选择多人模式连接服务地址进入，属于`Joker`的私人服，有感兴趣的可以一起玩。

## Minecraft 客户端:

[启动侠官网](http://www.qidongxia.com)， 选择精简版下载。

由于启动侠文件是`.exe`格式的，Linux/Mac用户需要安装`wine`来运行`.exe`程序。之后就可以正常使用了。

客户端所有文件都在 `/minecraft-client`目录下，其中`.minecraft`目录存放客户端相关文件，`.mclc`目录存放启动器配置等文件。目录下的`.exe`文件即时启动器。

考虑到不同的平台下运行客户端需要的文件不同，所以使用启动器自带的功能选择对应于服务器版本的客户端进行下载。

## Minecraft 服务器自建:

如果你想自己搭建服务和好友一起玩耍，可以把本项目布署到云端服务器(公网访问)，或者布署在自己的机器上(局域网访问)。

目前使用微软官方提供的纯净版服务器软件包[minecraft-server.1.12.2.jar](https://minecraft.net/zh-hans/download/server)

服务器软件需要在java环境下运行，所在需要安装`JDK`环境

### JDK 安装脚本

 如果你是Linux平台，使用`apt-get`的包管理器，可以使用`/minecraft/install-jdk`脚本来安装jdk到你的电脑

```
$ source minecraft/install-jdk
```

### Minecraft 服务器管理脚本

`/minecraft/minecraft-server/server` 该脚本用来管理` Minecraft SMP`服务器, 需要进入到`minecraft-server`目录下面运行，使用命令`./server start`即可启动服务器，本项目minecraft服务端口设定为`25566`

```
Usage:
  ./server [ -o | -v version | -m jvm_run_memory ] [ test | start | stop | status | archive | resume ]

Options:

  -o                  - run server with jvm optimize parameters
  -v version          - run specified version server
  -m jvm_run_memory   - run server with specified jvm run memeory alloced

Arguments:

  test    - Start the pure minecraft server in test mode
  start   - start the pure minecraft server(with o, you can use the JVM optimization options run server)
            if the server port has been used by other process, you can use 'lsof -i :portNum' to check
  stop    - stop the pure minecraft server
  status  - check the minecraft server run status
  archive - archive the world directory to minecraft/world-backup/*.tar.gz files
  resume  - resume the world archive file to the game world directory

Example:

  Start the Server:

      ./server -o -v 1.12.2 -m 1024M start

  Stop the Server:

      ./server stop

  Check the server status:

      ./server status

  Run the Server block the shell:

      ./server -o -v 1.12.2 -m 2048M test

  Archive the world directory to minecraft/world-backup/ directory:

      ./server archive

  Resume the world archive file to minecraft/minecraft-server/world directory:

      ./server resume
```

### 服务器配置相关

`eula.txt`文件需要改为：`eula=TRUE`, 也即同意`EULA`用户使用协议
[server.properties 说明文档](http://minecraft.gamepedia.com/Server.properties)
