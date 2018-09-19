
#' `purrr::modify_if` does not maintain class as promised for atomic vectors
#' -----------------------------------

# purrr
packageVersion("purrr")

# numeric
set.seed(101)
v <- runif(10)
class(v)
all.equal(v, purrr::modify_if(v, ~ . < 0.5, ~ . + 5))

# integer
nas <- c(5L, 6L, NA, 7L)
all.equal(nas, purrr::modify_if(nas, is.na, ~0L))

# character
all.equal(letters[1:5], purrr::modify_if(letters[1:5], ~.=="c", ~"C"))

