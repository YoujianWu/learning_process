##ros中的时间概念

> Time、Timer、Duration、TimeStamp



####time与duration

> ROS 里经常用到的一个变量就是时间，比如基于时间和控制量计算机器人的移动距离、设定程序的等待时间/循环时间、设定计时器等。本文总结了 roscpp 给我们提供的时间相关的操作。具体来说，roscpp 里有两种时间表示方法：时刻 (ros::Time) 和时长(ros::Duration)。其中Duration可以是负数。

一般情况下，这里的时间都是跟平台（即系统）的时间相关联的，但ROS提供了一种模拟时钟即ROS时钟时间，当进行了相应设置时，这里的时间就是ROS时钟时间（比如定时器）。ros的时间基准为Unix，起始时间为：1970年1月1日。

`Time` 和 `Duration` 表示的概念并不相同，`Time` 指的是某个时刻，而 `Duration` 指的是某个时段，尽管他们的数据结构都相同，但是应该用在不同的场景下。ROS为我们重载了 `Time`、`Duration` 类型之间的加减运算，避免了转换的麻烦。



基本用法

```
要使用 Time 和 Duration，需要分别 #include<ros/time.h> 和 #include <ros/duration.h>。（这是两个类）


ros::Time t1=ros::Time::now()-ros::Duration(5.5);//t1是5.5s前的时刻,Time加减Duration返回Time
ros::Time t2=ros::Time::now()+ros::Duration(3.3);//t2是当前时刻往后推3.3s的时刻
ros::Duration d1=t2-t1;//从t1到t2的时长，两个Time相减返回Duration类型
ros::Duration d2=d1-ros::Duration(0,300);//两个Duration相减，返回Duration
```

```
将ros::time 用于控制时

ros::time last_time=ros::time::now();//初始化时间（只调用一次）
void control(ros::time time)

int main()
{
	ros::time time_ = ros::time::now(); 
	control(time_);
}

void control(ros::time time)
{
	last_time = time；

}//在函数里传入时间,每循环进入一次就刷新一次时间

```

```
将ros::Duration 用于控制时

ros::time last_time_=ros::time::now();//初始化时间（只调用一次）
void control(ros::Duration period)

int main()
{
	
	ros::Duration period_ = ros::time::now()-last_time_; 
	control(period_);
	last_time_ = ros::time::now();
}

void control(ros::Duration period)
{
	ctrl_putter(period);

}//在函数里传入时间,每循环进入一次就刷新一次时间
```



#### ros::Timer和ros::Rate

首先需要说明的是，ROS并不是实时系统，所以定时器并不能确保精确定时。精确的执行时间以及理论上应该执行的时间可以在回调函数的ros::TimerEvent结构中得到。

但是它可以实现像单片机的定时器一样，定时一段时间，然后就触发一次回调函数，结束后再定时

```
ros::Timer ros::NodeHandle::createTimer(ros::Duration period, <callback>, bool oneshot = false);
ros::Timer timer = n.createTimer(ros::Duration(0.1), timerCallback);//定时0.1s
void timerCallback(const ros::TimerEvent& e);
```

```
struct TimerEvent
{
  Time last_expected;                     ///< In a perfect world, this is when the last callback should have happened
  Time last_real;                         ///< When the last callback actually happened
 
  Time current_expected;                  ///< In a perfect world, this is when the current callback should be happening
  Time current_real;                      ///< This is when the current callback was actually called (Time::now() as of the beginning of the callback)
 
  struct
  {
    WallDuration last_duration;           ///< How long the last callback ran for, always in wall-clock time
  } profile;
};
```



Rate 的功能是设定一个频率，让循环按照这个频率执行，然后通过睡眠度过一个循环中剩下的时间，来达到该设定频率，如果能够达到该设定频率则返回true，不能则返回false。计时的起点是上一次睡眠的时间、构造函数被调用、或者调用void ros::Rate::reset()函数重置时间。因为没有TimerEvent，所以相对于Timer而言，Rate的精确度会有所下降。与之类似的是 ROS 中的定时器 Timer，它是通过设定回调函数和触发时间来实现某些动作的循环执行。创建方法和 topic 中的 subscriber 类似。



####延时（睡眠）

> 通常在机器人任务执行中可能有需要等待的场景，这时就要用到 sleep 功能。roscpp中提供了两种 sleep 的方法:

```
几种方法

bool ros::Duration::sleep()
ros::Duration(0.5).sleep(); // sleep for half a second
 
ros::Duration(0.5).sleep();//一是用Duration对象的sleep方法休眠
 
ros::Rate   r(10);//10HZ
while(ros::ok())
{
    r.sleep(); //二是用 Rate 对象调整休眠时间，考虑循环中其他任务占用的时间，确保让整个循环的频率是 10hz 
}

也可以让定时器实现睡眠，但没必要浪费回调函数这个资源。
```

[ros中的时间概念](https://blog.csdn.net/QLeelq/article/details/111060608)



####ros中的TimeStamp

> 在ROS中，时间戳（timestamp）是用来表示某个事件发生时间的一种方式。时间戳通常由两部分组成：一个整数表示自某个特定时间点（如1970年1月1日00:00:00 UTC）到事件发生时的秒数（即“秒级时间戳”），以及一个整数表示事件发生时相对于秒级时间戳的纳秒数（即“纳秒偏移量”）。

面对通信机制中不断收发的信息，如何寻找到我们需要的信息呢？我们可以通过序列号（Header)和时间戳（TimeStamp)来寻找

常用与msg、tf中

[时间戳在tf中的应用](https://cc1924.blog.csdn.net/article/details/120586258?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-120586258-blog-129239932.235%5Ev38%5Epc_relevant_sort_base1&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-120586258-blog-129239932.235%5Ev38%5Epc_relevant_sort_base1&utm_relevant_index=2)
