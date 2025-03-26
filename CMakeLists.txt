# Copyright 2019 Arthur Sonzogni. All rights reserved.
# Use of this source code is governed by the MIT license that can be found in
# the LICENSE file.

cmake_minimum_required (VERSION 3.13)
project(asm-dom-cmake
  LANGUAGES CXX
  VERSION 0.1.0
)

# If needed, in release mode, use emscripten optimizations flags.
include(cmake/release-mode.cmake)

# Install gccx if needed. Defines the gccx(..) function to transpile cpx to cpp.
include(cmake/gccx.cmake)

# Add the asm-dom library.
include(cmake/asm-dom.cmake)

gccx(src/main.cpx)
add_executable(main src/main.cpp)
set_property(TARGET main PROPERTY CXX_STANDARD 11)
target_link_libraries(main PRIVATE asm-dom)

# Copy index.html after the target is built
add_custom_command(
  TARGET main
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_SOURCE_DIR}/src/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/product/index.html
  COMMENT "Copying index.html to the build directory"
)

# Copy style.css after the target is built
add_custom_command(
  TARGET main
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_SOURCE_DIR}/src/style.css
    ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/product/style.css
  COMMENT "Copying style.css to the build directory"
)

add_custom_command(
  TARGET main
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/main.js
    ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/product/main.js
)

add_custom_command(
  TARGET main
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/main.wasm
    ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/product/main.wasm
)
