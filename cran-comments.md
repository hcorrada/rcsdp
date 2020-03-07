## Test environments
* local OS X installation, R 3.6.2
* OS X installation (on github-actions), R 3.6.2
* ubuntu 16.04 (on github-actions), R 3.6.2
* windows (Rtools 3.5, on github-actions), R 3.6.2
* OS X installation (on github-actions), R-devel 

* solaris-x86-patched (using rhub)
* fedora-gcc-devel (using rhub)

## R CMD check results

0 errors | 0 warnings | 0 notes

## rchk results

rchk tests run using github-actions
rchk tests succeed  

## Downstream dependencies

Ran revdepcheck::revdep_check on local installation and found no problems except package 'Rdimtools' failed to install but not due to Rcsdp dependency (clang: error: unsupported option '-fopenmp')

## Version notes

This version (0.1.57) fixes remaining issues with CRAN check: (a) a warning in platform 'fedora-gcc-devel' for ignoring a return value, (b) an error in platform 'solaris-x86-patched' with environment variable CC (fixed in 0.56.1 by Brian Ripley)

