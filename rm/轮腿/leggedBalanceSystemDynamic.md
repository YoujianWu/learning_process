## leggedBalanceSystemDynamic

### 介绍

轮腿的模型用VMC方法将两个腿虚拟成一个摆，最终的模型是一个有上层机体的倒立摆，只是这个倒立摆的摆长会动态变化。可以算是二阶倒立摆



### 模型

- 状态

```c++
State = [x, theta_l, theta_r, alpha, psi, x_dot, theta_l_dot, theta_r_dot, alpha_dot, psi_dot]^T
```

```
- x 自然坐标系下的机器人水平移动距离
- theta_l VMC虚拟的出来的左摆与机体的夹角
- theta_r VMC虚拟的出来的右摆与机体的夹角
- alpha 机体倾斜角
- psi 机器人yaw旋转角度
    
- x_dot 自然坐标系下的机器人水平移动距离的速度(变化率)
- theta_l_dot VMC虚拟的出来的左摆与机体的夹角的角速度(变化率)
- theta_r_dot VMC虚拟的出来的右摆与机体的夹角的角速度(变化率)
- alpha_dot 机体倾斜角的角速度(变化率)
- psi_dot 机器人yaw旋转角度的角速度(变化率)
```

- 输入

```
Input = [tau_l_l, tau_l_r, tau_l, tau_r]^T
```

```
- tau_l_l 左腿部转矩
- tau_l_r 右腿部转矩
- tau_l 左轮转矩
- tau_r 右轮转矩
```



### 代码

- 首先是构造函数

```c++
LeggedBalanceSystemDynamics(const std::string& filename, const std::string& libraryFolder, bool recompileLibraries,
                              std::shared_ptr<LeggedBalanceControlCmd> balanceControlCmdPtr, LeggedBalanceParameters& param)
      : SystemDynamicsBaseAD(), balanceControlCmdPtr_(std::move(balanceControlCmdPtr)), param_(param) {
    initialize(STATE_DIM, INPUT_DIM, "legged_balance_dynamics", libraryFolder, recompileLibraries, true);
  }
```

```
- filename 任务文件
- libraryFolder 自动编译生成的模型文件存放的文件夹路径
- recompileLibraries 是否在运行程序是重新编译一次机器人的动力学模型
```

> 动力学自动微分对象基类中的initialize函数，verbose 是否打印具体信息

```
void initialize(size_t stateDim, size_t inputDim, const std::string& modelName, const std::string& modelFolder = "/tmp/ocs2",
                  bool recompileLibraries = true, bool verbose = true);
```