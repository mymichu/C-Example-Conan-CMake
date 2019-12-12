# Set the minimum version of CMake that can be used
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.16)

# Add an executable
add_executable(calculator main.c utils/calculator.c)


