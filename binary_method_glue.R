#' A binary method for Character strings
#' ---------------------
#'   * Do we want to allow a non-numeric argument to binary operator?
#'   * simply define your own class and S3 method(s)
# ------------------


#' A helper `infix` function

# alias for !x %in% y
`%!!%` <- function(x, y) {
  x[ !x %in% y ]
}

#' The Problem
#' -------------
shop <- structure(c("milk", "butter", "bread"),
                  class = c("fiber", "character"))
class(shop)

print.fiber <- function(x, ...) print(unclass(x))
shop

# Error
shop - "butter"

#' The Solution
#' -------------
# Using the helper
shop %!!% c("butter", "hotdogs")     # No 'butter' or 'hotdogs'

shop %!!% c("bread", "milk")         # No 'bread' or 'milk'

# And this allows you to write something like this,
# a non-numeric method dispatch to a binary operator for our `fiber` class!
`-.fiber` <- function(e1, e2) {
  e1 %!!% e2
}

#' Et Viola
#' -------------
# Use the new `-` S3 method
shop - "butter"


#' Let's try a `+` S3 method
#' -------------
`+.fiber` <- function(e1, e2) { c(e1, e2) }

# Use the new `+` S3 method
shop + "crayons"


