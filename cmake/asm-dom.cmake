# Copyright 2019 Arthur Sonzogni. All rights reserved.
# Use of this source code is governed by the MIT license that can be found in
# the LICENSE file.

message(STATUS "Checking for asm-dom: Please wait")
include(FetchContent)
FetchContent_Declare(asm-dom
  GIT_REPOSITORY https://github.com/izzyreal/asm-dom
  GIT_TAG master
)

FetchContent_GetProperties(asm-dom)
if(NOT asm-dom_POPULATED)
  FetchContent_Populate(asm-dom)
  add_library(asm-dom
    ${asm-dom_SOURCE_DIR}/cpp/asm-dom.cpp
    ${asm-dom_SOURCE_DIR}/cpp/asm-dom-server.cpp
    ${asm-dom_SOURCE_DIR}/cpp/asm-dom.hpp
    ${asm-dom_SOURCE_DIR}/cpp/asm-dom-server.hpp
  )
  set_property(TARGET asm-dom PROPERTY CXX_STANDARD 11)
  target_include_directories(asm-dom PUBLIC ${asm-dom_SOURCE_DIR}/cpp/)
  add_link_options(-sEXPORTED_RUNTIME_METHODS=['UTF8ToString'])
  add_link_options(-sWASM=1)
  add_link_options(--bind)
endif()

add_custom_command(
  TARGET asm-dom
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy
    ${asm-dom_SOURCE_DIR}/dist/js/asm-dom.js
    ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/product/asm-dom.js
)

message(STATUS "Checking for asm-dom: DONE")
