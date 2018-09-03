
#' `SomaPlyr::read.adat` possible issue
#' -------------------
#' Yolanda: problems with SurvData `SomaPlyr::read.adat`
#' reprex example of `SurvData` write/read
library(SomaPlyr)
is.intact.attributes(SurvData)
f <- tempfile(fileext = ".adat")
write(SurvData, file = f)
new <- read.adat(f)
class(new)
is.intact.attributes(new)
new
