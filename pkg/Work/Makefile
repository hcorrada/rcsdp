RUNIT_DIR=${shell pwd}
PKG_PATH=$(shell dirname ${RUNIT_DIR})

SOURCES=$(wildcard ${PKG_PATH}/src/*.c)
OBJECTS=$(patsubst %.c,%.o,$(SOURCES))

TARGET=Rcsdp
SHLIBNAME=$(firstword $(basename $(notdir ${SOURCES})))

PKG_VERSION=$(shell Rscript -e 'cat(read.dcf("${PKG_PATH}/DESCRIPTION", fields="Version")[1,])')
PKG_TARBALL=$(shell printf "Rcsdp_%s.tar.gz" ${PKG_VERSION})

all: build test check config

config: ${PKG_PATH}/src/Makevars

${PKG_PATH}/src/Makevars: ${PKG_PATH}/configure
	cd ${PKG_PATH}; \
	./configure

${PKG_PATH}/configure: ${PKG_PATH}/configure.ac
	cd ${PKG_PATH}; \
	autoconf --verbose

tarball: ${PKG_TARBALL}

${PKG_TARBALL}: config
	R CMD build ${PKG_PATH}
	
check: ${PKG_TARBALL}
	R CMD check ${PKG_TARBALL}

build: config ${PKG_PATH}/src/Csdp.ts ${TARGET}

${TARGET}: ${SOURCES}
	cd $(shell dirname $<); \
	R CMD SHLIB $(foreach SRC,${SOURCES},$(shell basename ${SRC}))

%.o: %.c

${PKG_PATH}/src/Csdp.ts: 
	make -C ${PKG_PATH}/src/Csdp/lib libsdp.a CC=${CC} CFLAGS="${CFLAGS} ${CPICFLAGS} -DNOSHORTS -I${PKG_PATH}/src/Csdp/include" AR=${AR} RANLIB=ranlib
	touch $@ 
	
cleanso:
	rm -f ${PKG_PATH}/src/*.so ${PKG_PATH}/src/*.o

cleansdp:
	rm -f ${PKG_PATH}/src/Csdp/lib/*.o ${PKG_PATH}/src/Csdp/lib/libsdp.a ${PKG_PATH}/src/Csdp.ts

clean: cleansdp cleanconf cleanso
	
cleanconf:
	rm -rf ${PKG_PATH}/src/config.log ${PKG_PATH}/src/config.status ${PKG_PATH}/src/autom4te.cache ${PKG_PATH}/src/Makevars ${PKG_PATH}/configure

test: 
	echo "shlib" ${SHLIBNAME} "sources" ${SOURCES} "sources[0]" ${SOURCES[0]}$
	R --slave --args ${SHLIBNAME} < runtests.R
