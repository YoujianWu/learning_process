# 使用minicom调试串口



> 队内设计了一块电路板，4pin的是串口，可以接收到dbus和裁判系统的数据，并传给NUC，在组装机器人时，要调试该电路板的串口，确认电路板是否有问题
>

- 首先连接机器人，并把rm_bringup跑起来

- 然后检查can0或者can1是否有问题

- ```
  sudo minicom -s
  ```

- 选择第三个Serial port setup，回车
- 输入大写A，回车
- 将/dev/modem改为/dev/usbDbus或者/dev/usbReferee

> ==usbDbus是dbus的串口，usbReferee是裁判系统的串口==，
>
> 然后就选择Exit，就可以收到对应串口的数据 