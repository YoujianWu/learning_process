### RmEcatSlave

RmEcatSlave为控制 rm 电机提供了一个高级接口，通过 EtherCAT（使用 CANopen over EtherCAT CoE 协议）进行控制，底层的通信协议是有soem_interface提供的

从站的操作模式

```
typedef enum
{
   /** Init state*/
   EC_STATE_INIT           = 0x01,
   /** Pre-operational. */
   EC_STATE_PRE_OP         = 0x02,
   /** Boot state*/
   EC_STATE_BOOT            = 0x03,
   /** Safe-operational. */
   EC_STATE_SAFE_OP        = 0x04,
   /** Operational */
   EC_STATE_OPERATIONAL    = 0x08,
   /** Error or ACK error */
   EC_STATE_ACK            = 0x10,
   EC_STATE_ERROR          = 0x10
} ec_state;
```



```
//
// Created by qiayuan on 23-5-14.
//

#pragma once

#include "rm_ecat_slave/Command.h"
#include "rm_ecat_slave/Configuration.h"
#include "rm_ecat_slave/Controlword.h"
#include "rm_ecat_slave/Reading.h"
#include "rm_ecat_slave/Sdo.h"

#include <soem_interface/EthercatSlaveBase.hpp>

#include <yaml-cpp/yaml.h>

#include <condition_variable>

namespace rm_ecat {


// 继承自ethercat从站基类
class RmEcatSlave : public soem_interface::EthercatSlaveBase {
 public:
  using SharedPtr = std::shared_ptr<RmEcatSlave>;
  void setTimeStep(double timeStep) { timeStep_ = timeStep; }
  void setState(uint16_t state);
  
  /*!
   * 等待从站运行到对应的状态.
   * @param state      期待从站以什么状态运行
   * @param slave      从站地址
   * @param maxRetries 重连次数
   * @param retrySleep 重连的时间间隔
   * @return True if the state has been reached within the timeout.
   */
  bool waitForState(uint16_t state, unsigned int maxRetries = 40, double retrySleep = 0.001);

  // 从设置文件配置rm电机驱动
  static SharedPtr deviceFromFile(const std::string& configFile, const std::string& name, uint32_t address);

  // Constructor
  RmEcatSlave() = default;
  RmEcatSlave(const std::string& name, uint32_t address);

  // 以下这些纯虚函数是需要重写的
  std::string getName() const override { return name_; }
  bool startup() override;
  
  // 将从站设置为初始化状态
  void shutdown() override;
  
  void updateWrite() override;
  void updateRead() override;
  PdoInfo getCurrentPdoInfo() const override { return pdoInfo_; }

  // Control
  void stageZeroCommand();
  void stageCommand(const Command& command);
  Command getStageCommand();
  
  // Readings
  Reading getReading() const;
  void getReading(Reading& reading) const;

  // Configuration
  bool loadConfigFile(const std::string& fileName);
  bool loadConfigNode(const YAML::Node& configNode);
  bool loadConfiguration(const Configuration& configuration);
  Configuration getConfiguration() const;

  // SDO
  bool getStatuswordViaSdo(Statusword& statusword);
  void setImuTrigger(CanBus bus, bool imuTrigger);
  void setGpioModes(uint8_t modes);

 private:
  std::string name_;
  double timeStep_{0.0};

  mutable std::mutex stagedCommandMutex_;
  Command stagedCommand_;

  mutable std::mutex readingMutex_;
  Reading reading_;

  Configuration configuration_{};
  Controlword controlword_{};
  PdoInfo pdoInfo_;
};

}  // namespace rm_ecat

```

