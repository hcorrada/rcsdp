RUNIT_DIR=$(shell pwd)
PKG_PATH=$(shell dirname ${RUNIT_DIR})

SOURCES=$(wildcard ${PKG_PATH}/src/*.c)
OBJECTS=$(patsubst %.c,%.o,$(SOURCES))

TARGET=Rcsdp


all: build test

build: ${PKG_PATH}/src/Csdp.ts ${TARGET}

${TARGET}: ${SOURCES}
	cd $(shell dirname $<); \
	R CMD SHLIB -o ${TARGET}.so $(foreach SRC,${SOURCES},$(shell basename ${SRC}))

%.o: %.c

${PKG_PATH}/src/Csdp.ts: 
	cd ${PKG_PATH}/src/Csdp/lib && make libsdp.a && touch $@ 
	
cleanso:
	rm -f ${PKG_PATH}/src/*.so ${PKG_PATH}/src/*.o

cleansdp:
	rm -f ${PKG_PATH}/src/Csdp/lib/*.o ${PKG_PATH}/src/Csdp/lib/libsdp.a ${PKG_PATH}/src/Csdp.ts

clean: cleansdp cleanconf cleanso
	
cleanconf:
	rm -rf ${PKG_PATH}/src/config.log ${PKG_PATH}/src/config.status ${PKG_PATH}/src/autom4te.cache ${PKG_PATH}/src/Makevars ${PKG_PATH}/configure

test: 
	R --slave < runtests.R
