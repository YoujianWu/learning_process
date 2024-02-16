主站与从站交流的 ethercat msgs

```
time stamp #时间戳

uint32 statusword #状态字

string[] names #电机名字
bool[] isOnline #can是否在线
bool[] isOverTemperature #温度是不是过高

float64[] position #位置数据
float64[] velocity #速度数据
float64[] torque #力矩数据
float64[] temperature #温度数据
```



```
string[] names #从站名字

RmSlaveReading[] readings #从站过来的所有数据
```

