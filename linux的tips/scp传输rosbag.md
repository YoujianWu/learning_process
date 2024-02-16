```
 将机器人电脑上的rosbag拉到本地
 scp dynamicx@192.168.1.104:/home/dynamicx/Documents/control/20230709_02_10/4.bag  /home/kook/Videos/
 
 scp -v 是将对应的文件夹拉下来
 
 # 对rosbag进行修复(有可能会成功)
 rosbag fix xxx.active
 rosbag reindex xxx.active
```

