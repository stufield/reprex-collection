#' The `NAMESPACE` allows isolation of internal code dependencies
#' -----------------------------------

# the `base::nrow()` function
# Depends on `base::dim()`
base::nrow

# use
nrow(mtcars)

# What happens if we redirect (overwrite) `dim()`?
dim <- function(x) c(66, 99)

# The new `dim()` function is working
dim(mtcars)

# But what about internally within `base::nrow()`?
nrow(mtcars)

#' How does it do that? Shouldn't it be `66`?
#'
#' Answer: It's all about NAMESPACE isolation
#' ------------
#'
