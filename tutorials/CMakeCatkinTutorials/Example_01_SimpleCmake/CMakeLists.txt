# 指定最小的 CMAKE 版本要求
cmake_minimum_required(VERSION 3.16)

# 设置项目名称
project(example1)

# 生成可执行文件
add_executable(example1 main.cpp otherFile.cpp otherFile.h)

#【cmake】命令行
# 根据 CMakeLists 生成对应的MakeFile
# cmake -S . -B ../build

# 根据 MakeFile 输出工程文件
# cmake --build ../build or make