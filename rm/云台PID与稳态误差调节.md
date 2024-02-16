### 云台PID与稳态误差调节

> 云台控制器与前馈相关的代码如下

```
  double resistance_compensation = 0.;
  if (std::abs(ctrl_yaw_.joint_.getVelocity()) > velocity_saturation_point_)
    resistance_compensation = (ctrl_yaw_.joint_.getVelocity() > 0 ? 1 : -1) * yaw_resistance_;
  else if (std::abs(ctrl_yaw_.joint_.getCommand()) > effort_saturation_point_)
    resistance_compensation = (ctrl_yaw_.joint_.getCommand() > 0 ? 1 : -1) * yaw_resistance_;
  else
    resistance_compensation = ctrl_yaw_.joint_.getCommand() * yaw_resistance_ / effort_saturation_point_;
  ctrl_yaw_.joint_.setCommand(ctrl_yaw_.joint_.getCommand() - k_chassis_vel_ * chassis_vel_->angular_->z() +
                              yaw_k_v_ * yaw_vel_des + resistance_compensation);
  ctrl_pitch_.joint_.setCommand(ctrl_pitch_.joint_.getCommand() + feedForward(time) + pitch_k_v_ * pitch_vel_des);
```

> 在配置文件里，与前馈相关的参数如下

```
      k_chassis_vel: 0.038 # 底盘速度前馈 
      k_v: 0.0 # yaw速度前馈
      resistance_compensation:
        resistance: 0.16 # 摩擦力
        velocity_saturation_point: 0.34 # 速度饱和点
        effort_saturation_point: 0.052 # 力矩饱和点
```

> 首先，我们要了解一个基本事实，队内的自制滑环与商业滑环相比，阻力较大，所以为了解决这个问题，我们要对这个摩擦进行补偿

- 怎么知道滑环的阻力？

> 先将前馈系数设置为0，包括k_chassis_vel，k_v，resistance，velocity_saturation_point，effort_saturation_point，
>
> 然后单独开启云台控制器，让yaw轴以匀速低速转动（例如 3 rad/s)，根据所学的物理知识，摩擦力矩等于自身的力矩，所以这时候的电机输出力矩就是滑环的阻力，这时候resistance就测出来了

- 调参顺序

> 我们以yaw的调节为例子。
>
> 首先，将所有前馈置0，PID中的I设置为0，然后调节PD参数，到云台响应较好（较硬）（抗干扰能力强，用手掰它的时候给你的力很大)
>
> 然后，resistance填入测得的摩擦力，velocity_saturation_point设置为0.3，effort_saturation_point设置为0.06，打开plotjugger，查看controller的pid里的error项（稳态时），然后加减 velocity_saturation_point/effort_saturation_point的值，直到稳态误差为0.002~0.003，==注意：调试过程中，云台不能出现振荡。==

> 最后，将控制器的积分限幅度设置为阻力的正负值（ i_clamp_max，i_clamp_min），调节i的值（往大了给），直到稳态误差为0.001，但是要确保云台不会振荡

> 然后再调节k_chassis_vel，k_v即可。

