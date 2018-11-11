#' `purrr::modify_if` does not maintain class as promised for atomic vectors
#' -----------------------------------

# purrr version
packageVersion("purrr")

v <- runif(10)
class(v)

# numeric
all.equal(class(v),
          class(purrr::modify_if(v, ~ . < 0.5, ~ . + 5)))

# integer
nas <- c(5L, 6L, NA, 7L)
all.equal(class(nas),
          class(purrr::modify_if(nas, is.na, ~0L)))

# character
all.equal(class(letters[1:5]),
          class(purrr::modify_if(letters[1:5], ~.=="c", ~"C")))
