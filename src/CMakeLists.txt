# Set the minimum version of CMake that can be used
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.10)

set(_USCXML_PATH ${CMAKE_CURRENT_SOURCE_DIR}/statemachine/uscxml)
set(_USCXML_GEN_PATH ${CMAKE_CURRENT_BINARY_DIR}/generated_uscxml)

MESSAGE(ERROR " hello ${_USCXML_GEN_PATH}")
MESSAGE(ERROR " hello ${_USCXML_GEN_PATH}")
MESSAGE(ERROR " hello ${_USCXML_GEN_PATH}")

set(_SCXML_FILE ${_USCXML_PATH}/doc/main_sm.scxml)
set(_GEN_SM_H_FILE ${_USCXML_GEN_PATH}/main_sm.h)

if (WIN32)
    #do something
    string(REPLACE "/" "\\" _WIN_SCXML_FILE "${_SCXML_FILE}")
    string(REPLACE "/" "\\" _WIN_GEN_SM_H_FILE "${_GEN_SM_H_FILE}")

    add_custom_command(
        OUTPUT ${_GEN_SM_H_FILE}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${_USCXML_GEN_PATH}
        COMMAND ${_USCXML_PATH}/generator/win/uscxml-transform.exe -tc -i ${_WIN_SCXML_FILE} -o ${_WIN_GEN_SM_H_FILE}
        DEPENDS ${_USCXML_PATH}/doc/main_sm.scxml
        COMMENT "Generating code for ${_USCXML_GEN_PATH}/main_sm.h. ${_WIN_SCXML_FILE} -o ${_WIN_GEN_SM_H_FILE}"
    )
else(WIN32)
    add_custom_command(
            OUTPUT ${_GEN_SM_H_FILE}
            COMMAND ${CMAKE_COMMAND} -E make_directory ${_USCXML_GEN_PATH}
            COMMAND ./uscxml-transform -tc -i ${_SCXML_FILE} -o ${_GEN_SM_H_FILE}
            DEPENDS ${_USCXML_PATH}/doc/main_sm.scxml
            COMMENT "Generating code for state-machine"
    )
endif (WIN32)





add_library(statemachine_obj
        ${_GEN_SM_H_FILE}
        statemachine/uscxml/uscxml_main_sm.c)


include_directories(calculator PUBLIC ${_USCXML_GEN_PATH})

# Add an executable
add_executable(calculator main.c utils/calculator.c $<TARGET_OBJECTS:statemachine_obj>)