cmake_minimum_required(VERSION 3.16)
# Function to prepend string infront of a list of files
function(Prepend var prefix)
  set(listVar "")
  foreach(f ${ARGN})
    list(APPEND listVar "${prefix}/${f}")
  endforeach()
  set(${var} "${listVar}" PARENT_SCOPE)
endfunction()