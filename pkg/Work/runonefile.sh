#!/bin/bash

RUNIT_DIR=$PWD
PKG_PATH=$(dirname ${RUNIT_DIR})
shopt -s nullglob
SOURCES=( ${PKG_PATH}/src/*.c )
SHLIBNAME=$(basename ${SOURCES[0]} .c)

TEST_FILE=$1

if test $# -ne 1 ; then
    echo "Usage: runonefile.sh SOMETEST.R"
    exit 1
fi

R_CODE="library(RUnit)"
R_CODE="${R_CODE};source(\"setuptests.R\")"
R_CODE="${R_CODE};res <- runTestFile('${TEST_FILE}',rngKind='default',rngNormalKind='default')"
R_CODE="${R_CODE};printTextProtocol(res)"

echo ${R_CODE} | R --slave --args ${SHLIBNAME}
