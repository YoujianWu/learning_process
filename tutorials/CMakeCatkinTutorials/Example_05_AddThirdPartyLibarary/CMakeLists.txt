# 指定最小的 CMAKE 版本要求
cmake_minimum_required(VERSION 3.16)

# 设置项目名称
project(example5)

# 指定 CXX 版本
set(CMAKE_CXX_STANDARD 14)
# 设置 CXX 版本要求，如果设置为OFF，就会使用上一版本
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 强制代码干净，编译器警告不再忽略，警告所有，警告错误
add_definitions(-Wall -Werror)

# find_package()是用来在系统中找已经安装第三方库的，REQUIRED是告诉编译器一定要找到，否则编译失败
# 找到会生成一个${Eigen3_LIBARARY}的宏，从而供可执行目标链接
find_package(Boost
        REQUIRED
        #COMPONENTS
        #这里跟的是对应的一些组件
        )

# 生成可执行文件
add_executable(example5 src/main.cpp)

# 链接对应的库
target_link_libraries(example5 ${Boost_Libarary})


#【cmake】命令行
# cmake -S . -B ../build
# cmake --build ../build