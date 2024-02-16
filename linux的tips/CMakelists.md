# CMakelists

> 作为刚入门的小白，相信你肯定被CMakelists各种折磨吧，那么现在我们就好好理清一下CMakelists是什么东西吧！

什么是汇编语言？ 因为机器语言全用0和1表示，不容易记忆，汇编语言可以理解为是机器语言的助记符。汇编语言由一系列的指令（助记符）组成。

我们在windows下使用不同的IDE写代码时（如vscode)，都是将代码写好，点击一下编译、运行，那么一个操作面板就会将我们的运行效果完整的展示在我们面前，那么IDE内部是如何将代码转换为机器认识的汇编语言的呢？

##gcc编译链和Makefile

> gcc编译链是GNU推出的一套编译工具链，方便我们将自己的代码转换成汇编语言

```
  Usage: gcc [options] file...
  
  -E                       Preprocess only; do not compile, assemble or link. //不编译，不汇编，不链接
  -S                       Compile only; do not assemble or link. //只编译
  -c                       Compile and assemble, but do not link. //只编译和汇编
  -o <file>                Place the output into <file>.  // 编译、汇编、链接，并把输出放到一个新文件里（不是重命名）

```

那么我们每次都要输入这些命令，有没有什么东西可以帮我们一键执行呢？

> Makefile文件就是这个有用的工具，编写好一个Makefile，我们就可以直接一个make就可以输出可执行文件，而windows和linux平台下的Makefile语法不同。于是编写Makefile变得很复杂。为了实现“write once,run everywhere"，就出现了CMake

## CMake

源代码要经过编译才能在系统上运行。linux下的编译器有gcc、g++,随着源文件的增加，又相继发展出了Makefile、CMake编译工具。==CMake简化了编译构建过程==，能够管理大型项目，具有良好的扩展性。

> CMake里面的CMakelists可以根据我们当前平台的环境生成不同的CMakefile，然后再通过cmake指令，生成对应的Makefile文件，然后再make一下就可以实现上面的一系列操作了。所以我们只要编写CMakelists就行了

## Catkin编译系统

==Catkin 是 ROS 基于CMake的编译构建系统。==

ROS原始的编译和打包系统是rosbuild，而ROS 官方自 ROS Groovy 版本开始指定用catkin系统取代了之前的 rosbuild 。 catkin结合了CMake宏和Python脚本，以在CMake的正常工作流程之上提供一些功能。 catkin比rosbuild设计的更规范，可以更好地分发软件包，具有更好交叉编译支持和更好的可移植性。 ==catkin的工作流程与CMake的工作流程非常相似，但是增加了对自动“find package”基础结构的支持，并能够同时构建多个相关项目。Catkin扩展了CMake，将 cmake 与 make 指令做了一个封装从而完成整个编译过程的工具==

```
catkin_make //这是基本的一个catkin编译命令

一个Catkin的软件包（package）必须要包括两个文件：CMakelists和package.xml
```

##catkin build

catkin build是对catkin make的封装

简单来说，如果ros的工作空间 (workspace) 中只有一个ros包（ros package)，那么catkin_make和catkin build区别不大；

如果一个caktin workspace里有多个ros包，那么catkin build显然是更好的编译工具。

因为catkin_make只是几行Cmake和make指令的简写，不管里面有几个包都一起编译了。

但是catkin_build会将工作空间里所有的包同时单独（isolated）编译，编译过程互不影响。

配合catkin init，catkin config, catkin create pkg, catkin build, catkin list, catkin clean等工具使用效果更佳哟。

###参考文献

[catkin编译系统](https://blog.csdn.net/zxxxiazai/article/details/108312127)

[catkin build的优势](https://blog.csdn.net/benchuspx/article/details/113847854)

by Youjian Wu