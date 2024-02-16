#shell 脚本

###如何编写一个简单的shell脚本呢？

> 让我们先从创建脚本文件开始

```
# 创建一个文件 test.sh
touch test.sh
# vim test.sh
```

> 如何让系统知道这是一个shell脚本呢？

```
# 在文件的头顶部加入这行代码
#!/bin/bash 
```

###如何运行一个shell 脚本呢?

```
#使脚本具有执行权限，执行脚本
chmod +x ./test.sh  
./test.sh  

#这样可以一键启动
sh 脚本的路径
bash 脚本的路径

#如
sh ~/openclion.sh
bash ./openclion.sh
```



### 脚本内容

> 脚本内容可以写入对应的命令



####一键启动clion

```
#!/bin/bash

sh /opt/clion/clion-2022.2.4/bin/clion.sh
roscore
```

