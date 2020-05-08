set(CMAKE_SYSTEM_NAME Linux)
#
#Compiler Settings
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
#
#TOOLS for text formatting
set(CLANG_FORMAT clang-format-10)
set(CLANG_FORMAT_STYLE ${CMAKE_CURRENT_SOURCE_DIR}/.clang-format)
#
#TOOLS for coverage
set(LLVM_COVERAGE_TOOL llvm-cov-10)
set(LLVM_PROFDATA_TOOL llvm-profdata-10)
set(MIN_LINE_COV 40)
set(MIN_BRANCH_COV 0)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
#


