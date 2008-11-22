#!/bin/bash

(cd ..; autoconf; cd Work)

if test -n $1 ; then
    R CMD INSTALL --configure-args=""$@"" ..
else
    R CMD INSTALL ..
fi

R_CODE="library(Rcsdp); example(csdp)"

echo ${R_CODE} | R --slave
R CMD REMOVE Rcsdp
make clean


