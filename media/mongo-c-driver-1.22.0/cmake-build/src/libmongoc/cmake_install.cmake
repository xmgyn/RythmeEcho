# Install script for directory: /home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE PROGRAM FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/mongoc-stat")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmongoc-1.0.so.0.0.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmongoc-1.0.so.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/libmongoc-1.0.so.0.0.0"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/libmongoc-1.0.so.0"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmongoc-1.0.so.0.0.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmongoc-1.0.so.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libbson:"
           NEW_RPATH "")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/libmongoc-1.0.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/libmongoc-static-1.0.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libmongoc-1.0/mongoc" TYPE FILE FILES
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/src/mongoc/mongoc-config.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/src/mongoc/mongoc-version.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-apm.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-bulk-operation.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-change-stream.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-client.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-client-pool.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-client-side-encryption.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-collection.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-cursor.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-database.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-error.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-flags.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-find-and-modify.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-gridfs.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-gridfs-bucket.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-gridfs-file.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-gridfs-file-page.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-gridfs-file-list.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-handshake.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-host-list.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-init.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-index.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-iovec.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-log.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-macros.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-matcher.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-opcode.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-optional.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-prelude.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-read-concern.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-read-prefs.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-server-api.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-server-description.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-client-session.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-socket.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-stream-tls-libressl.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-stream-tls-openssl.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-stream.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-stream-buffered.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-stream-file.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-stream-gridfs.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-stream-socket.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-topology-description.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-uri.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-version-functions.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-write-concern.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-rand.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-stream-tls.h"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/mongoc-ssl.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libmongoc-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/src/libmongoc/src/mongoc/forwarding/mongoc.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/src/libmongoc-1.0.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/src/libmongoc-static-1.0.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/src/libmongoc-ssl-1.0.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/mongoc-1.0/mongoc-targets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/mongoc-1.0/mongoc-targets.cmake"
         "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/CMakeFiles/Export/cc1ca9f5d410b47e5f99801e6c7d2b06/mongoc-targets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/mongoc-1.0/mongoc-targets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/mongoc-1.0/mongoc-targets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/mongoc-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/CMakeFiles/Export/cc1ca9f5d410b47e5f99801e6c7d2b06/mongoc-targets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/mongoc-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/CMakeFiles/Export/cc1ca9f5d410b47e5f99801e6c7d2b06/mongoc-targets-relwithdebinfo.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/mongoc-1.0" TYPE FILE FILES
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/mongoc/mongoc-1.0-config.cmake"
    "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/mongoc/mongoc-1.0-config-version.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/libmongoc-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/libmongoc-1.0-config.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/libmongoc-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/libmongoc-1.0-config-version.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/libmongoc-static-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/libmongoc-static-1.0-config.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/libmongoc-static-1.0" TYPE FILE FILES "/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/libmongoc-static-1.0-config-version.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/build/cmake_install.cmake")
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/examples/cmake_install.cmake")
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/src/cmake_install.cmake")
  include("/home/mgyn/Work/RythmeEcho/media/mongo-c-driver-1.22.0/cmake-build/src/libmongoc/tests/cmake_install.cmake")

endif()

