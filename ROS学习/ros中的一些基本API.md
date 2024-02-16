## ros中的基本API

> ros::spin()与ros::spinOnce()

> 它们都是ROS消息回调处理函数，两者区别在于前者调用后不会再返回，也就是你的主程序到这儿就不往下执行了，而后者在调用后还可以继续执行之后的程序。其实看函数名也能理解个差不多，一个是一直调用；另一个是只调用一次，如果还想再调用，就需要加上循环了。
>
> 这里一定要记住，ros::spin()函数一般不会出现在循环中，因为程序执行到spin()后就不调用其他语句了，也就是说该循环没有任何意义，还有就是spin()函数后面一定不能有其他语句(return 0 除外)，有也是白搭，不会执行的。ros::spinOnce()的用法相对来说很灵活，但往往需要考虑调用消息的时机，调用频率，以及消息池的大小，这些都要根据现实情况协调好，不然会造成数据丢包或者延迟的错误。
>
> 只要时ros自带的回调函数，都要spin一下，否则都收不到信息。

[消息回调函数](https://blog.csdn.net/qiqiqiqi0000/article/details/114905090?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-0-114905090-blog-121253618.235^v38^pc_relevant_sort_base1&spm=1001.2101.3001.4242.1&utm_relevant_index=3)

