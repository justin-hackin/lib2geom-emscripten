# FindGLIB.cmake
# <https://github.com/nemequ/gnome-cmake>
#
# CMake support for GLIB/GObject/GIO.
#
# License:
#
#   Copyright (c) 2016 Evan Nemerson <evan@nemerson.com>
#
#   Permission is hereby granted, free of charge, to any person
#   obtaining a copy of this software and associated documentation
#   files (the "Software"), to deal in the Software without
#   restriction, including without limitation the rights to use, copy,
#   modify, merge, publish, distribute, sublicense, and/or sell copies
#   of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be
#   included in all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#   DEALINGS IN THE SOFTWARE.

find_package(PkgConfig)

if(PKG_CONFIG_FOUND)
  pkg_search_module(GLIB_PKG glib-2.0)
endif()

find_library(GLIB_LIBRARY glib-2.0 HINTS ${GLIB_PKG_LIBRARY_DIRS})
set(GLIB glib-2.0)

if(GLIB_LIBRARY AND NOT GLIB_FOUND)
  add_library(${GLIB} SHARED IMPORTED)
  set_property(TARGET ${GLIB} PROPERTY IMPORTED_LOCATION "${GLIB_LIBRARY}")
  set_property(TARGET ${GLIB} PROPERTY INTERFACE_COMPILE_OPTIONS "${GLIB_PKG_CFLAGS_OTHER}")

  find_path(GLIB_INCLUDE_DIRS "glib.h"
    HINTS ${GLIB_PKG_INCLUDE_DIRS}
    PATH_SUFFIXES "glib-2.0")

  get_filename_component(GLIB_LIBDIR "${GLIB}" DIRECTORY)
  find_path(GLIB_CONFIG_INCLUDE_DIR "glibconfig.h"
    HINTS
      ${GLIB_LIBDIR}
      ${GLIB_PKG_INCLUDE_DIRS}
    PATHS
      "${CMAKE_LIBRARY_PATH}"
    PATH_SUFFIXES
      "glib-2.0/include"
      "glib-2.0")
  unset(GLIB_LIBDIR)

  if(GLIB_CONFIG_INCLUDE_DIR)
    file(STRINGS "${GLIB_CONFIG_INCLUDE_DIR}/glibconfig.h" GLIB_MAJOR_VERSION REGEX "^#define GLIB_MAJOR_VERSION +([0-9]+)")
    string(REGEX REPLACE "^#define GLIB_MAJOR_VERSION ([0-9]+)$" "\\1" GLIB_MAJOR_VERSION "${GLIB_MAJOR_VERSION}")
    file(STRINGS "${GLIB_CONFIG_INCLUDE_DIR}/glibconfig.h" GLIB_MINOR_VERSION REGEX "^#define GLIB_MINOR_VERSION +([0-9]+)")
    string(REGEX REPLACE "^#define GLIB_MINOR_VERSION ([0-9]+)$" "\\1" GLIB_MINOR_VERSION "${GLIB_MINOR_VERSION}")
    file(STRINGS "${GLIB_CONFIG_INCLUDE_DIR}/glibconfig.h" GLIB_MICRO_VERSION REGEX "^#define GLIB_MICRO_VERSION +([0-9]+)")
    string(REGEX REPLACE "^#define GLIB_MICRO_VERSION ([0-9]+)$" "\\1" GLIB_MICRO_VERSION "${GLIB_MICRO_VERSION}")
    set(GLIB_VERSION "${GLIB_MAJOR_VERSION}.${GLIB_MINOR_VERSION}.${GLIB_MICRO_VERSION}")
    unset(GLIB_MAJOR_VERSION)
    unset(GLIB_MINOR_VERSION)
    unset(GLIB_MICRO_VERSION)

    list(APPEND GLIB_INCLUDE_DIRS ${GLIB_CONFIG_INCLUDE_DIR})
    set_property(TARGET ${GLIB} PROPERTY INTERFACE_INCLUDE_DIRECTORIES "${GLIB_INCLUDE_DIRS}")
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLIB
    REQUIRED_VARS
      GLIB_LIBRARY
      GLIB_INCLUDE_DIRS
    VERSION_VAR
      GLIB_VERSION)
