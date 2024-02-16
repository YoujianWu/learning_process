# 安装ssh以及密钥登陆

[参考文章](https://blog.csdn.net/weixin_44129041/article/details/110355360?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-1.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-1.pc_relevant_default&utm_relevant_index=1)

   

## 安装ssh并使用密码登陆

1. 使用命令行安装ssh服务器

   ```
   sudo apt-get update
   sudo apt install openssh-server
   ```

2. 安装ssh客户端

   ```
   sudo apt install openssh-client
   ```

3. 启动ssh 服务

   ```
   sudo service ssh start //如果这里报错，说明openssh-server未安装完整，重新装一次就行了
   sudo service ssh stop //关闭ssh，无法连接，还有reload status等
   ```

4. 查找对应的ip

   ```
   ifconfig -a
   ```

5. 登陆ssh，即可实现远程访问

   ```
   ssh server_name@user_name
   ssh 用户名@IP地址
   ```

6. 退出ssh登录

   ```
   logout
   ```

例如在虚拟机上登陆我的电脑

```
ssh kook@192.168.1.66 #这里是无线网卡
```

##免密登陆

[参考文章](https://blog.csdn.net/weixin_44129041/article/details/110355360?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-1.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-1.pc_relevant_default&utm_relevant_index=1)
