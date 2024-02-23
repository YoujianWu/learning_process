## leggedBalanceInterface

### 介绍

> 先让我们来看看它的头文件

```c++
private:
  ocs2::sqp::Settings sqpSettings_;
  ocs2::mpc::Settings mpcSettings_;
  ocs2::ipm::Settings ipmSettings_;

  LeggedBalanceParameters param_;

  OptimalControlProblem problem_;
  std::shared_ptr<ReferenceManager> referenceManagerPtr_;

  std::unique_ptr<RolloutBase> rolloutPtr_;
  std::unique_ptr<Initializer> initializerPtr_;

  vector_t initialState_{STATE_DIM};

  std::shared_ptr<LeggedBalanceControlCmd> balanceControlCmdPtr_;
```

首先是内部私有成员：

- sqpSettings_ ，mpcSettings_，ipmSettings_

```c
这三个是优化算法对应参数配置的储存变量，方便后面直接调用getXXX()就能获取
```

- param_

```c
轮腿动力学参数对象，将配置文件里的读取到模型参数给param_，然后再把param_传给leggedBalanceDynamics,创建一个动力学对象，然后就可以调用它对应接口得到状态空间方程中的A，B阵
```

- problem_

```c
优化问题对象，要使用优化算法，当然要先确定这个优化问题，我们可以给这个优化问题的solver指针填入动力学对象，然后再将配置文件里的读取到的约束填进problem_里，那么这个优化问题就确定了
```

- referenceManagerPtr_

```c
同步模型指针，参考（轨迹）管理者指针，与mpc的优化计算同步，并且再最新一次优化之前就会调用一次preSolverRun()函数，更新系统的最新轨迹（输入），这个指针是用来创建rosReferenceManagerPtr的
```

- rolloutPtr_

```c
rolloutptr_，mpc优化反馈策略指针,后面用来传给mrt对象，执行反馈策略
```

- initializerPtr_

```c
这是求解器使用的接口类，用于在没有控制器的时间步长内初始化状态和输入。
```

- initialState_

```c
初始状态列向量
```

- balanceControlCmdPtr_

```c
轮腿控制命令共享指针，用来控制轮腿的运动状态的，注意是共享指针，储存的变量随其他共享指针的变化而变化
```



### 总结

legged_balance_interface是一个接口，里面加载了配置文件里的动力学参数部分，并用来赋给param内部变量，然后用param和leggedBalanceContrlCmd去初始化一个动力学对象，然后填入优化问题problem的dynamic指针里，这样优化问题就有动力学模型了，同时还将配置文件里的约束填进problem里，还设置了初始条件initializer，这样一个优化问题就建立了。同时还把后面处理这个优化问题的方法的一些参数也填进来，方便后面直接get就能获取。总的来说，我们可以从interface里面拿到动力学优化算法的配置参数，拿到优化问题，拿到同步器，拿到优化问题初始化器，拿到轮腿相关控制命令的共享指针，方便后面使用。

