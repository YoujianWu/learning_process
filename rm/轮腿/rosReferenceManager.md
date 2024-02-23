## rosReferenceManager

### 介绍

同步模型ros reference manager，通过订阅cmd_vel系列的话题，调用preSolveRun( )，在每次mpc解决优化之前，更新状态轨迹，然后再输入mpc，同时还将订阅到的命令set到共享指针legged_balance_cmd_ptr中，这样其他程序拿到这个legged_balance_cmd_ptr就能拿其中的命令继续去做其他的。



> 我们来看看它的成员函数

```c++
 public: 
  void subscribe(ros::NodeHandle& nodeHandle);
  void preSolverRun(scalar_t initTime, scalar_t finalTime, const vector_t& initState) override;

 private:
  bool tfVel(std::string from, std::string to, geometry_msgs::Vector3& vel);
```

- subscribe

```c++
void RosReferenceManager::subscribe(ros::NodeHandle& nodeHandle) {
  // Velocity command
  auto cmdVelCallback = [this](const geometry_msgs::Twist::ConstPtr& msg) {
    std::lock_guard<std::mutex> lock(cmdVelMutex_);
    cmdVelUpdated_ = true;
    cmdVel_ = *msg;
  };
  cmdVelSubscriber_ = nodeHandle.subscribe<geometry_msgs::Twist>("/cmd_vel", 1, cmdVelCallback);

  // Chassis command
  auto chassisCmdCallback = [this](const rm_msgs::ChassisCmd::ConstPtr& msg) {
    std::lock_guard<std::mutex> lock(chassisCmdMutex_);
    chassisCmdUpdated_ = true;
    chassisCmd_ = *msg;
  };
  chassisCmdSubscriber_ = nodeHandle.subscribe<rm_msgs::ChassisCmd>("/cmd_chassis", 1, chassisCmdCallback);

  // Leg length command
  auto legCmdCallback = [this](const std_msgs::Float64ConstPtr& msg) {
    std::lock_guard<std::mutex> lock(legCmdMutex_);
    legCmdUpdated_ = true;
    legCmd_ = *msg;
  };
  legCmdSubscriber_ = nodeHandle.subscribe<std_msgs::Float64>("leg_command", 1, legCmdCallback);

  // Body roll command
  auto rollCmdCallback = [this](const std_msgs::Float64ConstPtr& msg) {
    std::lock_guard<std::mutex> lock(rollCmdMutex_);
    rollCmdUpdated_ = true;
    rollCmd_ = *msg;
  };
  rollCmdSubscriber_ = nodeHandle.subscribe<std_msgs::Float64>("roll_command", 1, rollCmdCallback);

  // Robot jump command
  auto jumpCmdCallback = [this](const std_msgs::BoolConstPtr& msg) {
    std::lock_guard<std::mutex> lock(jumpCmdMutex_);
    jumpCmdUpdated_ = true;
    jumpCmd_ = *msg;
  };
  jumpCmdSubscriber_ = nodeHandle.subscribe<std_msgs::Bool>("jump_command", 1, jumpCmdCallback);
}

```

```c
subscribe()函数通过我们传进来的nodeHandle来订阅我们所有的命令话题，并将得到的命令赋值给内部变量
```

- preSolverRun

```c++
void RosReferenceManager::preSolverRun(ocs2::scalar_t initTime, ocs2::scalar_t finalTime, const ocs2::vector_t& initState) {
  static scalar_t yawTarget;
  static bool first = true;

  if (cmdVelUpdated_) {
    std::lock_guard<std::mutex> lock(cmdVelMutex_);
    cmdVelUpdated_ = false;

    if (first) {
      yawTarget = initState(4);
      first = false;
    }

    geometry_msgs::Vector3 vel;
    vel.x = cmdVel_.linear.x;
    vel.y = cmdVel_.linear.y;
    vel.z = 0;

    //轨迹
    ocs2::scalar_array_t timeTrajectory;
    ocs2::vector_array_t stateTrajectory;
    ocs2::vector_array_t inputTrajectory;
    
    //更新目标（预期）轨迹
    //并且设置最新的控制命令
    scalar_t horizon = finalTime - initTime;
    vector_t targetState = vector_t::Zero(rm::STATE_DIM);
    targetState(0) = initState(0) + vel.x * horizon;
    yawTarget += cmdVel_.angular.z * horizon;
    double yawError = angles::shortest_angular_distance(initState(4), yawTarget);
    targetState(4) = initState(4) + yawError;
    balanceControlCmdPtr_->setYawError(yawError);
    targetState(5) = vel.x;
    targetState(9) = vel.z;
    balanceControlCmdPtr_->setForwardVel(vel.x);

    //给referenceManagerPtr_的buffer里设置最新的轨迹
    timeTrajectory = {initTime, finalTime};
    stateTrajectory.assign(2, targetState);
    inputTrajectory.assign(2, vector_t::Zero(INPUT_DIM));
    referenceManagerPtr_->setTargetTrajectories({timeTrajectory, stateTrajectory, inputTrajectory});
  }

  if (chassisCmdUpdated_) {
    std::lock_guard<std::mutex> lock(chassisCmdMutex_);
    chassisCmdUpdated_ = false;
    balanceControlCmdPtr_->setPowerLimit(chassisCmd_.power_limit);
  }

  if (legCmdUpdated_) {
    std::lock_guard<std::mutex> lock(legCmdMutex_);
    legCmdUpdated_ = false;
    balanceControlCmdPtr_->setLegCmd(legCmd_.data);
  }

  if (rollCmdUpdated_) {
    std::lock_guard<std::mutex> lock(rollCmdMutex_);
    rollCmdUpdated_ = false;
    balanceControlCmdPtr_->setRollCmd(rollCmd_.data);
  }

  if (jumpCmdUpdated_) {
    std::lock_guard<std::mutex> lock(jumpCmdMutex_);
    jumpCmdUpdated_ = false;
    balanceControlCmdPtr_->setJump(jumpCmd_.data);
  }

  //将buffer里轨迹更新到mpc里
  referenceManagerPtr_->preSolverRun(initTime, finalTime, initState);
}
```

- tfVel

```c++
bool RosReferenceManager::tfVel(std::string from, std::string to, geometry_msgs::Vector3& vel) {
  if (from.empty()) {
    from = "yaw";
  }
  
  //buffer_.lookupTransform(to, from, ros::Time(0)) 获取旋转矩阵
  //doTransform 做速度转换
  try {
    tf2::doTransform(vel, vel, buffer_.lookupTransform(to, from, ros::Time(0)));
  } catch (tf2::TransformException& ex) {
    ROS_WARN("%s", ex.what());
    return false;
  }
  return true;
}
```

```c
tfVel()转换不同坐标系下的速度
```

