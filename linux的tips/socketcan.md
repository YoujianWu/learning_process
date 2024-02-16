#Socket CAN

[参考文章](https://www.cnblogs.com/longbiao831/p/4556255.html)

> Socket的中文翻译为“插座”，在计算机世界里称为套接字。Socket最初是作为网络上不同主机之间进程的通信接口，后来应用越来越广，在同一主机上的不同进程之间通信也可以用Socket。简单来说，当网络上不同主机之间的两个进程（A、B）采用Socket进行通信时，那么它们之间需要建立一个通信端点，即创建Socket，创建Socket时就分配端口号和网络地址。当进程A向进程B发送数据时，那么进程A必须要知道进程B的网络地址及端口号。





# 在命令行上使用Socket CAN接口

[参考文章](https://blog.mbedded.ninja/programming/operating-systems/linux/how-to-use-socketcan-with-the-command-line-in-linux/)

> 查看目前本地已经连接上的can设备，只有当我们接上can设备时才会有所显示
>
> ip link这个命令也很形象，就是将socket连接本地网络地址

```
ip link show
ifconfig //可以查看所有的接口
ifconfig can1 //可以查看指定的接口
```

> 在使用(enable)Socket CAN接口前，需要对socket的进行配置(比特率最高为1M Hz)

```
sudo ip link set can0 type can bitrate 1000000
```

> 在can总线上发送数据

```
cansend can0 123#112233
```

> 展示在can总线上收到的实时消息

```
candump can0
```

