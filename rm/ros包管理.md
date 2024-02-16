## ROS Package 管理

- 第一种方法

> 由于⼀些依赖的 ROS Package 只需要当为依赖编译⼀次后就不再改动，因此我们可以把
> 它放在另⼀个⼯作空间当成软件依赖源，与我们需要开发的 Package 在⼯作空间上分离

```
mkdir install_ws && cd install_ws && mkdir src
echo ${ROS_PACKAGE_PATH} #catkin_ws确保输出没有依赖到下的包路径，否则会造成循环依赖catkin install 
# 设置 install 模式
catkin config -DCMAKE_BUILD_TYPE=Release
catkin build <Dependent_ROS_Package>
cd ~/catkin_ws
source ~/install_ws/install/setup.bash
catkin config --merge-devel
catkin build <Package_In_catkin_ws> #使⽤catkin_ws 下的包时，记得 source ~/catkin_ws/devel/setup.bash

```

**clion project config**

**-DCATKIN_DEVEL_PREFIX=../devel**
**编译 catkin_ws 下包时，保证 ${ROS_PACKAGE_PATH} 为**
**/home/luohx/install_ws/install/share:/opt/ros/noetic/share**



- ==第二种方法（推介）==

> 由于第三方软件包只需要编译一次就不需要再次编译，所以需要将第三方成熟的包放在另一个工作空间

```
mkdir -p depend_ws/src

#设置 install 模式
catkin install 

# build_type 为release比debug的代码运行地快一点
catkin config -DCMAKE_BUILD_TYPE=Release 
```

> 清注释掉所有你source过的工作空间，保证echo ${ROS_PACKAGE_PATH}的输出为/opt/ros/noetic/share
>
> 如果不是，请重新开一个终端或在source ./.bashrc

```
catkin build
```

> 然后回到你的rm_ws下

```
catkin clean
```

> 清注释掉所有你source过的工作空间，保证echo ${ROS_PACKAGE_PATH}的输出为/opt/ros/noetic/share
>
> 如果不是，请重新开一个终端或在source ./.bashrc
>
> 直接设置depend_ws为依赖

```
catkin config --extend /home/xxxx/depend_ws/install
```

```
catkin build
```



