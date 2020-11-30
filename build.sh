#!/bin/sh
emcmake cmake . \
    -DDoubleConversion_INCLUDE_DIR:PATH=${LIBS_DIR}/double-conversion/ \
    -DDoubleConversion_LIBRARY:FILEPATH=${LIBS_DIR}/double-conversion/libdouble-conversion.a \
    -DGLIB_PKG_INCLUDE_DIRS:PATH=${LIBS_DIR}/glib-emscripten/target/ \
    -DGLIB_PKG_LIBRARY_DIRS:FILEPATH=${LIBS_DIR}/glib-emscripten/target/lib/libglib-2.0.a \
    -DGSL_INCLUDE_DIR:PATH=${LIBS_DIR}/gsl \
    -DGSL_LIBRARY:FILEPATH=${LIBS_DIR}/gsl/libgsl.a \
    -DGSL_CBLAS_LIBRARY:FILEPATH=${LIBS_DIR}/gsl/libgslcblas.a \
    -D2GEOM_TESTING=OFF \
    -DCMAKE_CXX_FLAGS="-sUSE_BOOST_HEADERS=1" \
    -DCMAKE_C_FLAGS="-sUSE_BOOST_HEADERS=1" \
&& make
