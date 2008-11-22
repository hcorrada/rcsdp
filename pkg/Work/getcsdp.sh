#!/bin/bash

URL="http://www.coin-or.org/download/source/Csdp"
LATEST="Csdp-6.0.1.tgz"
DESTINATION=../src/Csdp

if [[ -n "$@" ]] ; then
    rm -rf $DESTINATION
    rm -f $LATEST
    exit 1
fi

sources=${LATEST}
wget ${URL}/${sources}

CSDP=`basename ${sources} .tgz`
SOURCEDIR=${CSDP}

tar xzf ${sources}

if [[ ! -d $DESTINATION ]] ; then
    mkdir $DESTINATION
fi

cp -r $SOURCEDIR/* $DESTINATION
if [[ -d $SOURCEDIR ]] ; then
    rm -rf $SOURCEDIR
fi

