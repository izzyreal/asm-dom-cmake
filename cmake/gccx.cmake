# Copyright 2019 Arthur Sonzogni. All rights reserved.
# Use of this source code is governed by the MIT license that can be found in
# the LICENSE file.

# Ensure gccx is installed in the correct location
if (NOT EXISTS ${CMAKE_SOURCE_DIR}/node_modules/.bin/gccx)
  execute_process(COMMAND npm install gccx WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
endif()

# Function
#   gccx(<file.cx>)
#
# Description:
#   Add command to produce <file.cpp> from <file.cpx>.
#
# Notes:
#   The gccx file path must be relative to ${CMAKE_CURRENT_SOURCE_DIR}
#
# Example:
#   gccx(main.cpx)
function(gccx source)
  get_filename_component(name ${CMAKE_CURRENT_SOURCE_DIR}/${source} NAME_WE)
  get_filename_component(src_dir ${CMAKE_CURRENT_SOURCE_DIR}/${source} DIRECTORY)
  get_filename_component(gen_dir ${CMAKE_CURRENT_BINARY_DIR}/${source} DIRECTORY)

  file(MAKE_DIRECTORY ${gen_dir})

  add_custom_command(
    OUTPUT
      ${gen_dir}/${name}.cpp
    COMMAND
      ${CMAKE_SOURCE_DIR}/node_modules/.bin/gccx  # Fix: Use ${CMAKE_SOURCE_DIR} instead of ${CMAKE_CURRENT_BINARY_DIR}
    ARGS
      ${src_dir}/${name}.cpx
      -o ${gen_dir}/${name}.cpp
    MAIN_DEPENDENCY
      ${src_dir}/${name}.cpx
  )
endfunction()

