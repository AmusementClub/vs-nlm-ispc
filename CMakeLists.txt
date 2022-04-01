cmake_minimum_required(VERSION 3.20.0)

project(vs-nlm-ispc VERSION 0.1 LANGUAGES CXX ISPC)

add_library(vsnlm_ispc SHARED source/vsnlm.cpp source/nlm.ispc)

set_target_properties(vsnlm_ispc PROPERTIES
    CXX_EXTENSIONS OFF
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
)

find_package(PkgConfig QUIET MODULE)

if(PKG_CONFIG_FOUND)
    pkg_search_module(VS vapoursynth)

    if(VS_FOUND)
        message(STATUS "Found VapourSynth r${VS_VERSION}")

        cmake_path(APPEND install_dir ${VS_LIBDIR} vapoursynth)
        target_include_directories(vsnlm_ispc PRIVATE ${VS_INCLUDE_DIRS})

        install(TARGETS vsnlm_ispc LIBRARY DESTINATION ${install_dir})
    endif()
endif()

if(NOT VS_FOUND)
    set(VS_INCLUDE_DIR "" CACHE PATH "Path to VapourSynth headers")

    if(VS_INCLUDE_DIR STREQUAL "")
        message(WARNING "VapourSynth not found")
    endif()

    target_include_directories(vsnlm_ispc PRIVATE ${VS_INCLUDE_DIR})

    install(TARGETS vsnlm_ispc LIBRARY RUNTIME)
endif()

if(VCS_TAG)
    message(STATUS "vs-nlm-ispc ${VCS_TAG}")
else()
    message(WARNING "unknown plugin version")
    set(VCS_TAG "unknown")
endif()

configure_file(source/config.h.in config.h)

target_include_directories(vsnlm_ispc PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
