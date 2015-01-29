macro(config_cmake)
    # debug库后缀
    set(CMAKE_DEBUG_POSTFIX d)
    # 目标输出目录
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/bin)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/bin)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/lib)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/lib)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/bin)
endmacro()

macro(config_compiler_and_linke)
    if (MSVC)
        vc_ignore_warnings(
            4819 # 代码页编码错误
            4996 # stdio.h,  string.h等C可能不安全
            4800 # int转bool
            )
    endif(MSVC)
endmacro(config_compiler_and_linker)

function(cxx_shared_library name)
  add_library(${name} SHARED ${ARGN})
endfunction()

function(cxx_library name)
  if (BUILD_SHARED_LIBS)
      set(type SHARED)
  else()
      set(type STATIC)
  endif()
  add_library(${name} ${type} ${ARGN})
endfunction()

# 使用第三方库，添加include路径，lib路径
function(use_3rd_libraries)
    foreach(name ${ARGN})
        if(${name} STREQUAL ".")
            include_directories(${PROJECT_SOURCE_DIR}/include)
            link_directories(${PROJECT_SOURCE_DIR}/lib)
        else()
            include_directories(${PROJECT_SOURCE_DIR}/3rdparty/${name}/include)
            link_directories(${PROJECT_SOURCE_DIR}/3rdparty/${name}/lib)
        endif()
    endforeach()
endfunction()

# 使用库，库路径不在当前项目内
function(use_library name)
    include_directories(${name}/include)
    link_directories(${name}/lib)
endfunction(use_library)

# 单元测试需要链接的库
function(utest_link_libraries)
    set(UTEST_LIBRARIES ${ARGN} CACHE INTERNAL "UTEST_LIBRARIES")
endfunction()

# 添加单元测试
# @param [in] name 单元测试名，被测试文件名
function(add_utest name)
    set(TESTCASE ${name}_test)
    add_executable(${TESTCASE} ${name}_test.cpp)
    target_link_libraries(${TESTCASE} ${UTEST_LIBRARIES})
    add_test(${PROJECT_NAME} ${TESTCASE})
endfunction()

# vc忽略指定警告
function(vc_ignore_warnings)
    foreach(num ${ARGN})
        add_definitions(/wd"${num}")
    endforeach()
endfunction()

# 生成目标pdb文件
function(output_pdb target)
    set_target_properties(${target} PROPERTIES COMPILE_FLAGS "/Zi")
    set_target_properties(${target} PROPERTIES LINK_FLAGS "/DEBUG")
endfunction()
