# 指定最小的 CMAKE 版本要求
cmake_minimum_required(VERSION 3.16)

# 指定 CXX 版本
set(CMAKE_CXX_STANDARD 14)
# 设置 CXX 版本要求，如果设置为OFF，就会使用上一版本
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 强制代码干净，编译器警告不再忽略，警告所有，警告错误
add_definitions(-Wall -Werror)

# 设置项目名称
project(example6)

# 添加 inlcude 文件夹
include_directories(
        include
)

# 将自己的代码添加为库目标，避免重复造轮子，STATIC 指定为静态库
add_library(libmyCode src/otherFile.cpp)

# 生成可执行文件
# ${PROJECT_NAME}是cmake的宏
add_executable(${PROJECT_NAME} src/main.cpp)
# 在生成指定目标的时候，要求libmyCode先编译完
add_dependencies(${PROJECT_NAME} libmyCode)
# 为我们的可执行目标 target 链接库目标
target_link_libraries(${PROJECT_NAME} libmyCode)


# Mark executables and/or libraries for installation
install(
        TARGETS ${PROJECT_NAME}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin
)

# Mark cpp header files for installation
# ”*.h“ matching header files
install(
        DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
        DESTINATION include
        FILES_MATCHING PATTERN "*.h"
)

# Mark other files for installation
install(
        DIRECTORY doc
        DESTINATION share
)

#【cmake】命令行
# cmake -S . -B ../build
# sudo make install