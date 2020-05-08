cmake_minimum_required(VERSION 3.16)

Set(COVERAGE_COMMAND "")
set(COVERAGE_ARTIFACT_FOLDER ${CMAKE_CURRENT_BINARY_DIR}/coverage)
set(COVERAGE_ARTIFACT_FOLDER_GCOV ${COVERAGE_ARTIFACT_FOLDER}/gcov)
set(COVERAGE_ARTIFACT_FOLDER_GCOV_LOG ${COVERAGE_ARTIFACT_FOLDER}/gcov/log)

function(EnableCoverage )
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} --coverage" PARENT_SCOPE)
    # Enable special coverage flag (HINT: --coverage is a synonym for -fprofile-arcs -ftest-coverage)
    SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} --coverage" PARENT_SCOPE)
    SET(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG} --coverage" PARENT_SCOPE)
    SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} --coverage" PARENT_SCOPE)
    Message("coverage is enabled")
endfunction(EnableCoverage)

function(AppendCoverage TEST SOURCES)
    foreach(SOURCE_ITEM IN LISTS SOURCES)
        if("${SOURCE_ITEM}" MATCHES ".c$")
            message("SOURCE ${SOURCE_ITEM}")
            get_filename_component(FILE_NAME ${SOURCE_ITEM} NAME)
            get_filename_component(FILE_PATH ${SOURCE_ITEM} PATH)
            get_filename_component(SRC_DIR "${FILE_PATH}" NAME)
            #get_filename_component(a_second_last_dir "${a_second_dir}" NAME)
            message("FILE_NAME ${SRC_DIR}/${FILE_NAME}")
            set(COVERAGE_COMMAND ${COVERAGE_COMMAND} && llvm-cov gcov -b -c -u -o=${CMAKE_CURRENT_BINARY_DIR}/test/CMakeFiles/${TEST}.dir/__/src/${SRC_DIR} ${FILE_NAME}.gcno > ${COVERAGE_ARTIFACT_FOLDER_GCOV_LOG}/${FILE_NAME}.log PARENT_SCOPE)
        endif()
    endforeach()
endfunction(AppendCoverage TEST SOURCES)


function(AddCoverageCommand)
    if ("${CMAKE_C_COMPILER_ID}" MATCHES "(Apple)?[Cc]lang" OR "${CMAKE_CXX_COMPILER_ID}" MATCHES "(Apple)?[Cc]lang")
        
        message("Building with llvm Code Coverage Tools")
        message("COVERAGE FOLDER ${COVERAGE_ARTIFACT_FOLDER}")
        add_custom_target(
           coverage-prepare
           COMMAND rm -rf ${COVERAGE_ARTIFACT_FOLDER}
           COMMAND mkdir -v -p ${COVERAGE_ARTIFACT_FOLDER}
           COMMAND mkdir -v -p ${COVERAGE_ARTIFACT_FOLDER_GCOV}
           COMMAND mkdir -v -p ${COVERAGE_ARTIFACT_FOLDER_GCOV_LOG}
        )
        add_custom_target(
            coverage-export
            DEPENDS coverage-prepare
            COMMAND cd ${COVERAGE_ARTIFACT_FOLDER_GCOV} ${COVERAGE_COMMAND} 
            COMMAND gcovr -r ${CMAKE_SOURCE_DIR}/.. --use-gcov-files --gcov-ignore-parse-errors --keep --xml ${COVERAGE_ARTIFACT_FOLDER}/coverage-report-cobertura.xml --html-details ${COVERAGE_ARTIFACT_FOLDER}/coverage-report-detail.html --sonarqube ${COVERAGE_ARTIFACT_FOLDER}/coverage-report-sonar.xml --fail-under-line ${MIN_LINE_COV} --fail-under-branch ${MIN_BRANCH_COV} 
        )
    elseif (CMAKE_COMPILER_IS_GNUCXX)
        message("Building with lcov Code Coverage Tools")
        set(CMAKE_CXX_FLAGS "--coverage" PARENT_SCOPE)
        set(CMAKE_C_FLAGS "--coverage" PARENT_SCOPE)
    endif ()
endfunction(AddCoverageCommand )

function(AddTestReport TEST_SOURCE_FOLDER TEST_APPLICATION)
    set(TEST_ARTIFACT_FOLDER ${CMAKE_CURRENT_BINARY_DIR}/test-report)
    add_custom_target(
        test-report-prepare
        COMMAND rm -rf ${TEST_ARTIFACT_FOLDER}
        COMMAND mkdir -p ${TEST_ARTIFACT_FOLDER}
    )
    add_custom_target(
        test-report-export
        DEPENDS test-report-prepare
        COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${TEST_SOURCE_FOLDER}/bin/${TEST_APPLICATION} -r sonarqube > ${TEST_ARTIFACT_FOLDER}/test-report.xml 
    )
    add_custom_target(
        test-report-export-junit
        DEPENDS test-report-export
        COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${TEST_SOURCE_FOLDER}/bin/${TEST_APPLICATION} -r junit > ${TEST_ARTIFACT_FOLDER}/test-report-junit.xml 
    )
endfunction(AddTestReport )