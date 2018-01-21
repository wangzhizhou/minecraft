FROM ubuntu
WORKDIR /minecraft-server
ADD ./minecraft-server/minecraft_server.1.12.jar /minecraft-server

#安装JDK1.8
WORKDIR /
RUN apt-get update
RUN apt-get install -y wget
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jre-8u144-linux-x64.tar.gz
RUN tar -zxf jre-8u144-linux-x64.tar.gz
RUN rm jre-8u144-linux-x64.tar.gz
RUN mv jre* JRE
 
# 配置JDK环境变量  
ENV JRE_HOME /JRE
ENV CLASSPATH .:$JRE_HOME/lib  
ENV PATH $PATH:$JRE_HOME/bin  

#端口设置
EXPOSE 25565

#启动Minecraft服务器
WORKDIR /data
CMD ["java", "-Xmx4096M", "-Xms4096M", "-jar" ,"/minecraft-server/minecraft_server.1.12.jar","nogui"]
