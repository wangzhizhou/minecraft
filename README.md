# The Minecraft Game private repo for deploy

## Minecraft Client Software:

### 启动器

[启动侠官网](http://www.qidongxia.com)， 选择精简版下载。

由于启动侠文件是`.exe`格式的，Linux/Mac用户需要安装`wine`来运行`.exe`程序。之后就可以正常使用了。

客户端所有文件都在 `/minecraft-client`目录下，其中`.minecraft`目录存放客户端相关文件，`.mclc`目录存放启动器配置等文件。目录下的`.exe`文件即时启动器。

考虑到不同的平台下运行客户端需要的文件不同，所以使用启动器自带的功能选择对应于服务器版本的客户端进行下载。

## Minecraft Server Software:

### 服务端配置说明文档

[server.properties 说明文档](http://minecraft.gamepedia.com/Server.properties)

### Minecraft Server

目前更新到了`minecraft-server.1.12.2.jar`

### 官方只有购买正版才能使用，注册帐号只能试用

* Windows: [MinecraftInstaller.msi](https://launcher.mojang.com/download/MinecraftInstaller.msi) | [Minecraft.exe](https://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.exe)
* MacOs: [Minecraft.dmg](https://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.dmg) 
* GNU/Linux: [Minecraft.jar](https://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar)

### 当前目录结构

```
minecraft/
.
├── Dockerfile
├── README.md
├── doc
│   ├── docs
│   └── mkdocs.yml
├── docker-deploy.yml
├── install-jdk
├── minecraft-client
│   └── MCLC.exe
├── minecraft-server
│   ├── eula.txt
│   ├── minecraft_server.1.12.2.jar
│   ├── server
│   ├── server.properties
│   └── world
└── world-backup
    └── world-20180121030321.tar.gz

6 directories, 11 files
```

# shell 脚本使用说明

- 如果你是Linux平台，使用`apt-get`的包管理器，可以使用`/minecraft/install-jdk`脚本来安装jdk到你的电脑

```
$ source minecraft/install-jdk
```

- `/minecraft/minecraft-server/server` 该脚本用来启动` Minecraft SMP`服务器, 需要进入到`minecraft-server`目录下面运行

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

