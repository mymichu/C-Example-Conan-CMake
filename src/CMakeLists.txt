# Set the minimum version of CMake that can be used
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.16)

#Include Conan
link_directories(${CONAN_LIB_DIRS})
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS)


#Define Source and headers
SET(SRC_FILE_LIST
    utils/calculator.h
    utils/calculator.c)
    
#Create Object-library
add_library(calculator_obj OBJECT "${SRC_FILE_LIST}")

#Add Currentfolder and make Files Public
find_package("Utility" REQUIRED)
Prepend(SOURCE_LIST_ABSOLUTE ${CMAKE_CURRENT_SOURCE_DIR} ${SRC_FILE_LIST})
set(SRC_FILES ${SOURCE_LIST_ABSOLUTE} ${HEADER_LIST_ABSOLUTE} PARENT_SCOPE)

# Add an executable
add_executable(calculator main.c $<TARGET_OBJECTS:calculator_obj>)

