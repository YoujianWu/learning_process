## cmake

```
#指定cmake的版本要求
cmake_minimum_required(VERSION 3.23)

#指定工程的名字
#生成对应的环境变量PROJECTY_NAME
project(learning_cmake)

#设置C++标准
#set() 可以设置多种环境变量的值
#如：CMAKE_INSTALL_PREFIX(指定安装目录的前缀）
#set(CMAKE_INSTALL_PREFIX $(PROJECT_SOURCE_DIR)/install)
set(CMAKE_CXX_STANDARD 14)

#声明头文件的位置，以当前cmakelist的位置为参考位置
include_directories(include)

#生成动态共享库 
#生成之后，通过install之后，就可以直接#include <hello.h>了
#SHARED STATIC（静态）
#（库名 库类型 组成文件）
# ${PROJECT_SOURCE_DIR} 输出的值为顶层cmakelist所在的位置
add_library(hello SHARED ${PROJECT_SOURCE_DIR}/src/hello.cpp ${PROJECT_SOURCE_DIR}/include/hello.h)

#将对应文件声明为可执行文件
#若对应的模块不声明为库，就要将其声明为可执行部分，否则运行时就找不到对应的模块的实现
add_executable(learning-cmake src/main.cpp )

#链接对应的库
#（工程名 库名）
target_link_libraries(learning-cmake hello)

#安装对应的文件
#为了防止生成的文件随意生成，可以这样将生成的文件整理好
#不过好像只能在build下，cmake ..然后再make install?
#CMAKE_INSTALL_PREFIX(指定安装目录的前缀）
#INSTALL(TARGETS myrun mylib mystaticlib
       RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
       LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
       ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}) (目标文件选定，然后后面三个选一个)
#install(FILES(普通的文本文件) ${PROJECT_SOURCE_DIR}/include/hello.h DESTINATION include)
set(CMAKE_INSTALL_PREFIX $(PROJECT_SOURCE_DIR)/install)
install(TARGETS hello(这里可以是二进制文件，动态库之类）LIBRARY DESTINATION lib(安装库到lib下))
```

```
catkin-tools 必须要在工作空间根目录下执行，~/rm_ws就是一个根目录
```



###catkin特有的优化

> 队里使用的cmakelists

```
cmake_minimum_required(VERSION 3.10)
project(rm_manual)

## Use C++14
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

## By adding -Wall and -Werror, the compiler does not ignore warnings anymore,
## enforcing cleaner code.
## 忽略所以的警告与错误
add_definitions(-Wall -Werror -Wno-address-of-packed-member)

## Find catkin macros and libraries
find_package(serial REQUIRED)

find_package(catkin REQUIRED
        COMPONENTS
        roscpp
        sensor_msgs
        rm_msgs
        rm_common
        tf2_geometry_msgs
        serial
        std_msgs
        actionlib
        nav_msgs
        )

## Find system libraries
#find_package(Eigen3 REQUIRED)

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if your package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
        INCLUDE_DIRS
        include
        LIBRARIES
        CATKIN_DEPENDS
        roscpp
        sensor_msgs
        rm_msgs
        rm_common
        tf2_geometry_msgs
        std_msgs
        actionlib
        nav_msgs
        DEPENDS
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
        include
        ${catkin_INCLUDE_DIRS}
)

## Declare cpp executables
## FILE()可以选中所有的源文件
## 生成对应的target
FILE(GLOB ALL_SOURCES "src/*.cpp")
add_executable(${PROJECT_NAME} ${ALL_SOURCES})

## Add dependencies to exported targets, like ROS msgs or srvs
add_dependencies(${PROJECT_NAME}
        ${catkin_EXPORTED_TARGETS}
        )

## Specify libraries to link executable targets against
target_link_libraries(${PROJECT_NAME}
        ${catkin_LIBRARIES}
        )

#############
## Install ##
#############

# Mark executables and/or libraries for installation
install(
        TARGETS ${PROJECT_NAME}
        ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

# Mark cpp header files for installation
install(
        DIRECTORY include/${PROJECT_NAME}/
        DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
        FILES_MATCHING PATTERN "*.h"
)

## Mark other files for installation
install(
        DIRECTORY launch
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

#############
## Testing ##
#############

#if (${CATKIN_ENABLE_TESTING})
#  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
#  ## Add gtest based cpp test target and link libraries
#  catkin_add_gtest(${PROJECT_NAME}-test
#      test/test_ros_package_template.cpp
#      test/AlgorithmTest.cpp)
#  target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME}_core)
#endif ()

```

