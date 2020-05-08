cmake_minimum_required(VERSION 3.16)
set(CMAKE_CXX_STANDARD 14)

#Include Conan
link_directories(${CONAN_LIB_DIRS})
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS)

#Code Coverage Configuration
add_executable(testCalcAdd calculator_test.cpp ${SRC_FILES})  
target_link_libraries(testCalcAdd CONAN_PKG::Catch2)