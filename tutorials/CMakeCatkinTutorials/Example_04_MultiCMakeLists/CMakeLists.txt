# 指定最小的 CMAKE 版本要求
cmake_minimum_required(VERSION 3.16)

# 设置项目名称
project(example4)

# 指定 CXX 版本
set(CMAKE_CXX_STANDARD 14)
# 设置 CXX 版本要求，如果设置为OFF，就会使用上一版本
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 强制代码干净，编译器警告不再忽略，警告所有，警告错误
add_definitions(-Wall -Werror)

# 添加下一级目录
add_subdirectory(Code)

#【cmake】命令行
# cmake -S . -B ../build
# cmake --build ../build