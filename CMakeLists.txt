cmake_minimum_required(VERSION 2.8)

project(main)

include(cmake/internal_utils.cmake)

config_cmake()
config_compiler_and_linker()

add_subdirectory(src)
# add_subdirectory(test)
