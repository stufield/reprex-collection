

#' Foo
#'
#' A *tabular* test of `pkgdown`.
#'
#' @section: A Table
#' \tabular{lll}{
#'   a     \tab `b` \cr
#'   foo   \tab bar \cr
#' }
#' @param x A character string.
#' @export foo
foo <- function(x) print(x)


# reprex
library("pkgdown")
packageVersion("pkgdown")
table <- "\\tabular{ll}{a \\tab b \\cr c \\tab d}"
pkgdown:::rd2html(table)

table <- "\\tabular{ll}{a \\tab \\code{b} \\cr c \\tab d}"
pkgdown:::rd2html(table)


https://stackoverflow.com/questions/48100458/how-to-smooth-ecdf-plots-in-r

https://www.shanelynn.ie/themes-and-colours-for-r-ggplots-with-ggthemr/
