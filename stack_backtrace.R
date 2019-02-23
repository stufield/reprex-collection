
#' Fantastic stack backgraces with `rlang::entrace()`
#' -----------
#' A much nicer way to view the stack trace

library(rlang)

f <- function(x) {
  x + g(x)
}

g <- function(y) {
  foo <- y * 2
  bar <- paste0(foo, h())
  bar - 100
}

h <- function() {
  stop("error out here", call. = FALSE)
}

f(pi)

#' But you must call for the `traceback()` separately

traceback()

#' Much more convenient to set the `errorHandler` intercept in `.Rprofile`

options(error = quote(rlang::entrace()),
        rlang__backtrace_on_error = "collapse")   # or 'full'

f(3.14)

#' Another example:
#' ----------------
#' We're not in a project, so this should error out:
usethis::proj_path()
