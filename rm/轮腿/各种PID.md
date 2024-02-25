## 各种PID

在leggedBalanceController里面有各种PID

```yaml
    #follow的pid
    pid_follow: { p: 7.0, i: 0, d: 0.3, i_max: 0.0, i_min: 0.0, antiwindup: true, publish_state: true }
    
#腿部控制器通过调节腿部支持力控制腿长，使机器人保持滚转（roll）方向稳定，并起到主动悬挂的作用。
    #腿长度的pid
    #PD控制器模拟弹簧系统，用与模拟主动悬挂的作用
    #I用来消除前馈误差，pid_length_diff 前馈的PID
    pid_left_leg: { p: 200.0, i: 3, d: 0.1, i_clamp_max: 0.1, i_clamp_min: -0.1, antiwindup: true, publish_state: true }
    pid_right_leg: { p: 200.0, i: 3, d: 0.1, i_clamp_max: 0.1, i_clamp_min: -0.1, antiwindup: true, publish_state: true }
    #腿长度差的pid，防止腿离地的时候长度差过大，此项不要过于激进
    pid_length_diff: { p: 0.5, i: 0, d: 0.0, i_clamp_max: 0.0, i_clamp_min: -0.0, antiwindup: true, publish_state: true }
    
    #机器人roll角度的pid
    #PD控制器模拟弹簧系统，用于模拟主动悬挂的作用
    pid_roll: { p: 4.0, i: 0.0, d: 0.5, i_max: 0.0, i_min: -0.0, antiwindup: true, publish_state: true }
    
    #腿角度差的pid，防止劈叉
    #缩小腿之间的角度差
    pid_theta_diff: { p: 0.5, i: 0.0, d: 0.00, i_max: 0.0, i_min: 0.0, antiwindup: true, publish_state: true }
    
    #重心补偿的pid
    #由于机器人重心变化会导致水平位移发生变化，所以我们要对机器人的发生的位移进行积分
    #将积分的值补偿到驱动轮电机上三
    pid_center_gravity: { p: 0.0, i: 0, d: 0, i_max: 0.0, i_min: -0.0, antiwindup: true, publish_state: true }
```

