# Set the minimum version of CMake that can be used
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.16)

# Set the project name
project (calculatorapp)

include(${CMAKE_BINARY_DIR}/conan_paths.cmake)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

#Coverage
find_package("CoverageTest" REQUIRED)
EnableCoverage()
AddTestReport("test" testCalcAdd)



#Build
include_directories(src)
add_subdirectory(src)
add_subdirectory(test)

include(CTest)
enable_testing()
add_test(NAME testCalcAdd COMMAND testCalcAdd)

#Code-Formater
find_package("Format" REQUIRED)
set(ALL_FORMAT_SOURCES 
    ${SRC_FILES})
AddTargetFormat("${ALL_FORMAT_SOURCES}")

#ADD SOURCES COVERAGE
AppendCoverage(testCalcAdd "${SRC_FILES}")
AddCoverageCommand()