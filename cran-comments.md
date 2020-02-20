## Test environments
* local OS X installation, R 3.6.2
* OS X installation (on github-actions), R 3.6.2
* ubuntu 16.04 (on github-actions), R 3.6.2
* windows (Rtools 3.5, on github-actions), R 3.6.2
* OS X installation (on github-actions), R-devel 

## R CMD check results

0 errors | 0 warnings | 0 notes

## rchk results

rchk tests run using github-actions
rchk tests succeed  

## Downstream dependencies

Ran revdepcheck::revdep_check on local installations and found no problems. Only package Rdimtools failed, but from clang issue on
installation (clang: error: unsupported option '-fopenmp')

## Version notes

This version (0.1.56) removes use of R CMD config for variable CPP in configure script. See NEWS.md file for further updates.
