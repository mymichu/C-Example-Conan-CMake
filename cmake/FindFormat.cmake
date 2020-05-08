cmake_minimum_required(VERSION 3.16)
function(AddTargetFormat FORMAT_SOURCES)
    #USE Clang format to format source files with command format
    if(NOT CLANG_FORMAT)
        message(STATUS "clang-format not found.")
    else()
        message(STATUS "Use Clang Format ${CLANG_FORMAT_STYLE}")
        add_custom_target(
            check-format-files
            COMMAND ${CLANG_FORMAT} --Werror --dry-run -style=file ${FORMAT_SOURCES}
        )
        add_custom_target(
            auto-format-files
            COMMAND ${CLANG_FORMAT} -i -style=file ${FORMAT_SOURCES}
        )
    endif()
endfunction(AddTargetFormat )



