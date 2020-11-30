include(FindPackageHandleStandardArgs)

find_path(GLIB_LIBRARY PATHS ${GLIB_DIR})
find_path(GLIB_INCLUDE_DIR glib-2.0/libglib-2.0.a PATHS ${GLIB_DIR})

find_path(GLIB_CONFIG_INCLUDE_DIR glib-2.0/include/glibconfig.h
    PATHS ${GLIB_DIR})

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
  set(GLIB_INCLUDE_DIRS ${GLIB_INCLUDE_DIR} ${GLIB_INCLUDE_})
endif()
