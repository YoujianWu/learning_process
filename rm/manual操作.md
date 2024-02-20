# rm_manual

rm_manual是一个专门用于与裁判系统交互的软件包，主要是用于向裁判系统发送以及接收大量数据和操作手界面（UI）的绘制。



## Input_event

> 在rm_manual的include里面有一个input_event.h的头文件。正如这个名字，它代表了一些事件的触发与否，让我们来看看它是怎么实现的事件触发的吧

在manual_base.cpp里

```
  right_switch_down_event_.setRising(boost::bind(&ManualBase::rightSwitchDownRise, this));
  right_switch_mid_event_.setRising(boost::bind(&ManualBase::rightSwitchMidRise, this));
  right_switch_up_event_.setRising(boost::bind(&ManualBase::rightSwitchUpRise, this));
  left_switch_down_event_.setRising(boost::bind(&ManualBase::leftSwitchDownRise, this));
  left_switch_up_event_.setRising(boost::bind(&ManualBase::leftSwitchUpRise, this));
  left_switch_mid_event_.setEdge(boost::bind(&ManualBase::leftSwitchMidRise, this),
                                 boost::bind(&ManualBase::leftSwitchMidFall, this));
  robot_hp_event_.setEdge(boost::bind(&ManualBase::robotRevive, this), boost::bind(&ManualBase::robotDie, this));
```

> 这里的boost::bind(&ManualBase::rightSwitchUpRise, this)是一个绑定函数，可以将对应的函数绑定，传入setRising里面
>
> 在这个里就是绑定了rightSwitchUpRise()这个函数指针

在manual_base.h里

```
amespace rm_manual
{
class InputEvent
{
public:
  InputEvent() : last_state_(false)
  {
  }
  void setRising(boost::function<void()> handler) //对应的事件设置为上升沿
  {
  	//boost::function<void()> 可以返回一个指针f,在这里对应的就是void类型，无传入参数的指针 handler
  	//std::move可以将一个左值转换成右值
  	//那么此时rising_handler_储存的就是handler这个函数指针
  	rising_handler_ = std::move(handler);
  }
  void setFalling(boost::function<void()> handler) //对应的事件设置为下降沿
  {
    falling_handler_ = std::move(handler);
  }
  void setActiveHigh(boost::function<void(ros::Duration)> handler) //对应的事件设置为持续上升沿
  {
    active_high_handler_ = std::move(handler);
  }
  void setActiveLow(boost::function<void(ros::Duration)> handler) //对应的事件设置为持续下降沿
  {
    active_low_handler_ = std::move(handler);
  }
  void setEdge(boost::function<void()> rising_handler, boost::function<void()> falling_handler)
  {
  	//对应的事件设置为双边沿
    rising_handler_ = std::move(rising_handler);
    falling_handler_ = std::move(falling_handler);
  }
  void setActive(boost::function<void(ros::Duration)> high_handler, boost::function<void(ros::Duration)> low_handler)
  {
    //
    active_high_handler_ = std::move(high_handler);
    active_low_handler_ = std::move(low_handler);
  }
  
  //以上都是一些事件触发的设置
  //下面的update函数就i实现了相应函数的触发
  void update(bool state)
  {
    if (state != last_state_)
    {
      if (state && rising_handler_)
        rising_handler_();
      else if (!state && falling_handler_)
        falling_handler_();
      last_state_ = state;
      last_change_ = ros::Time::now();
    }
    if (state && active_high_handler_)
      active_high_handler_(ros::Time::now() - last_change_);
    if (!state && active_low_handler_)
      active_low_handler_(ros::Time::now() - last_change_);
  }

private:
  bool last_state_;
  ros::Time last_change_;
  boost::function<void(ros::Duration)> active_high_handler_, active_low_handler_;
  boost::function<void()> rising_handler_, falling_handler_;
};
```



## 运行节点

> 在rm_manual这个包下的src里面，我们可以找到一个main.cpp，这个节点主要是循环运行一个run函数，run函数是写在manual_base里面的一个虚函数，由其子类进行不同的实现，main中会根据robot type的不同，调用不同之类的run函数

- 步兵：chassis_gimble_shooter_cover_manual

- 英雄：chassis_gimble_shooteer_manual
- 工程：engineer_manual

> 那么为了了解run函数到底做了哪些工作，让我们用ctrl+鼠标左键，进入到run函数中一探究竟

## run函数

> 因为不同的子类的run函数都有不同的实现，下面只对步兵的run函数进行分析



##command_sender

> 在rm_control下面的rm_common里面的command_sender专门给manual用的
>
> 不同的comand_sender在不同的manual里面的事件回调函数调用
>
> command_sender里面又调用了heat_limit或者poewr_limit

