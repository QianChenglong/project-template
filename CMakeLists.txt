cmake_minimum_required(VERSION 2.8)

project(main)

include(cmake/internal_utils.cmake)

config_cmake()

ignore_warnings(
    4819 # 代码页编码错误
    4996 # stdio.h,  string.h等C可能不安全
    4800 # int转bool
    )

add_subdirectory(src)
add_subdirectory(test)
