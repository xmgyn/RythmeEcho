# Install script for directory: /home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libbson-1.0.so.0.0.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libbson-1.0.so.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/libbson-1.0.so.0.0.0"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/libbson-1.0.so.0"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libbson-1.0.so.0.0.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libbson-1.0.so.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/libbson-1.0.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/libbson-static-1.0.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libbson-1.0/bson" TYPE FILE FILES
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/src/bson/bson-config.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/src/bson/bson-version.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bcon.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-atomic.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-clock.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-cmp.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-compat.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-context.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-decimal128.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-endian.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-error.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-iter.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-json.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-keys.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-macros.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-md5.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-memory.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-oid.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-prelude.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-reader.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-string.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-types.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-utf8.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-value.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-version-functions.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/bson-writer.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libbson-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libbson/src/bson/forwarding/bson.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/src/libbson-1.0.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/src/libbson-static-1.0.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/bson-1.0/bson-targets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/bson-1.0/bson-targets.cmake"
         "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/CMakeFiles/Export/6b6c9c432ffbcc14133f82ac0df53b76/bson-targets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/bson-1.0/bson-targets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/bson-1.0/bson-targets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/bson-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/CMakeFiles/Export/6b6c9c432ffbcc14133f82ac0df53b76/bson-targets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/bson-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/CMakeFiles/Export/6b6c9c432ffbcc14133f82ac0df53b76/bson-targets-relwithdebinfo.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/bson-1.0" TYPE FILE FILES
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/bson/bson-1.0-config.cmake"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/bson/bson-1.0-config-version.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/libbson-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/libbson-1.0-config.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/libbson-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/libbson-1.0-config-version.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/libbson-static-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/libbson-static-1.0-config.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/libbson-static-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/libbson-static-1.0-config-version.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/build/cmake_install.cmake")
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/examples/cmake_install.cmake")
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/fuzz/cmake_install.cmake")
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/src/cmake_install.cmake")
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson/tests/cmake_install.cmake")

endif()

