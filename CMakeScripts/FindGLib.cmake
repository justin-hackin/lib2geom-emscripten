include(FindPackageHandleStandardArgs)

find_library(GLIB_LIBRARY NAMES glib-2.0 PATHS ${GLIB_DIR}/lib/)

find_path(GLIB_INCLUDE_DIR glib.h HINTS ${GLIB_DIR}/include/glib-2.0/)

find_path(GLIB_CONFIG_INCLUDE_DIR glibconfig.h
    PATHS ${GLIB_DIR}/lib/glib-2.0/include/)

find_package_handle_standard_args(GLIB DEFAULT_MSG
  GLIB_DIR
  GLIB_LIBRARY
  GLIB_INCLUDE_DIR
  GLIB_CONFIG_INCLUDE_DIR)

mark_as_advanced(
    GLIB_DIR
    GLIB_LIBRARY
    GLIB_INCLUDE_DIR
    GLIB_CONFIG_INCLUDE_DIR)

if(GLIB_FOUND)
  set(GLIB_LIBRARIES ${GLIB_LIBRARY})
  set(GLIB_INCLUDE_DIRS ${GLIB_INCLUDE_DIR} ${GLIB_CONFIG_INCLUDE_DIR})
endif()
