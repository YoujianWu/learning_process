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

# 额外配置
# 调用我们的库时还可以使用我们的头文件
# 指定编译给定目标时使用的 include 目录
# ${CMAKE_CURRENT_SOURCE_DIR} 目前 source 的 CMakeLists 路径
target_include_directories(libmyCode PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
# 指定特定的库用指定的CXX版本要求编译
target_compile_features(libmyCode PRIVATE cxx_std_11)

# 输出信息
message(STATUS "now CMAKE_CURRENT_SOURCE_DIR is ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "${PROJECT_NAME} is already finished")


#【cmake】命令行
# cmake -S . -B ../build
# cmake --build ../build