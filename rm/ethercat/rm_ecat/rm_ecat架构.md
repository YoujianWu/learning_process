###rm_ecat架构

```
RmEcatSlave-->RmSlaveManage-->RmBusManagerr-->clearSlaveManager->RmSlaveManagerROS->ROS
```

```
首先由rmSlaveManger解析关于从站的信息，然后由rmBusManager首先构建好一个抽象的ethercat bus，然后由rmSlave与bus取得沟通，将对应的信息读取出来，然后就完成了底层的构建，rmSlaveManager->getReading();

由rmEcatHardwareInterface给rmSlaveManager发布电机命令，rmSlaveManger给rmEcatslave发布command,再通过rxpdo发给ethercat
```

