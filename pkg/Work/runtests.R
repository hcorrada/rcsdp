library(RUnit)

# load R files and shared object
source("setuptests.R")

suite <- defineTestSuite("Rcsdp Unit Tests",
                         dirs=c("."),
                         testFileRegexp="^runit.+\\.R$",
                         testFuncRegexp="^test.+",
                         rngKind="default",
                         rngNormalKind="default")
res <- runTestSuite(suite)
printTextProtocol(res)

