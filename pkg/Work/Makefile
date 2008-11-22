RUNIT_DIR=$(shell pwd)
PKG_PATH=$(shell dirname ${RUNIT_DIR})

SOURCES=$(wildcard ${PKG_PATH}/src/*.c)
OBJECTS=$(patsubst %.c,%.o,$(SOURCES))

TARGET=Rcsdp.so


all: build test

build: ${TARGET}

${TARGET}: ${SOURCES}
	cd $(shell dirname $<); \
	R CMD SHLIB -o ${TARGET} $(foreach OBJ,${OBJECTS},$(shell basename ${OBJ}))

%.o: %.c

cleanso:
	rm -f ${PKG_PATH}/src/*.so ${PKG_PATH}/src/*.o

clean: cleanconf cleanso
	rm -f ${PKG_PATH}/src/Csdp/lib/*.o ${PKG_PATH}/src/Csdp/lib/libsdp.a ${PKG_PATH}/src/Csdp.ts ${PKG_PATH}/src/Makevars ${PKG_PATH}/configure

cleanconf:
	rm -rf ../config.log ../config.status ../autom4te.cache

test: 
	R --slave < runtests.R
