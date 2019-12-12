cmake_minimum_required(VERSION 3.16)
set(CMAKE_CXX_STANDARD 14)

include_directories(../src)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS)

#Code Coverage Configuration
link_directories(${CONAN_LIB_DIRS})
add_executable(testCalcAdd calculator_test.cpp ../src/utils/calculator.c) 
target_link_libraries(testCalcAdd CONAN_PKG::Catch2 ${CONAN_LIBS})