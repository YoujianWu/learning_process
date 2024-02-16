# 配nuc

> 拿到一块nuc，先不要急着配环境，先看一下nuc上面的硬件是否齐全，比如说内存条，固态之类的

> 然后再找一个可以外接的显示屏（属于是当作显卡来用了），然后找到给nuc供电的适配器，找不到电源的话，就随便找个电脑的充电器，看一下输入输出是否符合就可以了

> 有可能会遇到以下问题
>
> 1. ==显示器无信号==，可以换HDMI线给显示屏供信号
> 2. ==找到一个启动盘==，检查总体接线
> 3. 打开nuc电源开关，“滴“声之后，即是开机成功
> 4. 直到正常打开nuc，并显示在显示器上

### 怎么进bios？

> 在重装系统前，必须要进入bios里面的boot选项里，把你的启动盘作为首要启动对象，然后保存设置，重启即可

```
# 可以手动进bios
# 也可以用命令进bios
sudo systemctl reboot --firmware-setup
```

> 重启后选择 install ubuntu server
>
> 按队内文档进行分盘就行

> ==注意==，完善信息的时候，user-name是@前面的，即dynamicx
>
> server-name是@后面的，即hero

### 安装easywifi

安装ssh，并通过ssh用你的电脑操控nuc

将自己的电脑连接上wifi，然后用一根网线将nuc和你的电脑连接。这时你的电脑左上方会出现有线连接的图标。进入有线连接，点击设置，点击IPV4,设置“与其他计算机共享网络”（类似的意思）。这样nuc就能上网了。可用`ping baidu.com`来检查是否已联网。

> 由于刚装好的ubuntu系统无法联网（无图形化界面，所以必须手动给其联网），用一根网线将其与自己的电脑连起来，然后用nmap 10.42.0.1/24 扫描出它的ip，然后ssh上去，就可以正常操作了（因为你的电脑联网了）

会出现的问题

> 1. 有线网卡存在，但是它ip a 后找不到，nmap也扫不到对应的ip，==解决方法==：用手机给它提供网络，用一条typeC连接手机和nuc，然后在它上面ip a就能找到这个接口（类似叫作usb0这样的）
>
>    ```
>    # 但要给它分配ip地址
>    dhclient usb0
>    # 然后看看能不能上网
>    ping www.bilibili.com
>    ```
>
>    [参考文章](https://blog.51cto.com/u_15077549/4316908)
>
> 2. 有线网卡存在，但是它ip a 后找不到，nmap也扫不到对应的ip
>
>    这个应该是配置的问题，因为部分nuc需要自行配置
>    
>    ```
>    sudo lshw -c Network
>    # 显示Ethernet interface的状态为disable
>       
>    sudo touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf
>       
>    sudo systemctl restart NetworkMnager
>    ```
>    
>    重启后或者换内核之后应该就好了
>

### 安装ROS

> 安装ros请主要参考ros_wiki上的安装教程。请注意安装base而不是full-desktop。
>
> 要是安装失败就换源，一般都需要先换源（阿里，清华...)

###安装[catkin tools](https://dynamic-x-docs.netlify.app/quick_start/quick_start_in_control_group.html#catkin-tools)

catkin tools官方文档：https://catkin-tools.readthedocs.io/en/latest/ 如果你使用catkin build时需要你安装osrf-pycommon>0.1.1这个依赖，请输入以下指令：

```
sudo apt-get install python3-pip
pip3 install osrf-pycommon
```

> 然后创建一个工作空间，把对应的包拉进去
>
> 我们团队为 **rm_control** 和 **rm_controllers** 搭建了软件源，请根据 [这个网站](https://rm-control-docs.netlify.app/quick_start/rm_source) 给nuc添加软件源并把相应的软件包拉下来。
>
> ==不要直接把这两个包直接clone下来，否则编译时会安装图形化界面的依赖！==

###安装rosdepc

###按照队内文档进行优化即可