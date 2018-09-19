#' Use `expand.grid` or `purrr::cross_df` instead of nesting `purrr::map`
#' ---------------------
#'   * As Hadley points out on Twitter, it's better to set up
#'   your combinations up front
#'   * Then use `purrr::map2` or `purrr::pmap` to iterate over the rows
#'   * Nesting `purrr::map` calls should be avoided if possible
# ------------------
library(purrr)

#' In case you haven't learned about `purrr::cross` (and it's variants).
#' It's simply the `purrr` version of `expand.grid`:

expand.grid(mean = 1:3, sd = 1:3)
cross_df(list(mean = 1:3, sd = 1:3))

#' Now we are in a perfect situation to use `purrr::pmap` to loop over rows
#' with named arguments

cross_df(list(mean = 1:3, sd = 1:3)) %>%   # all combos
  pmap_dbl(dnorm, x = 0.5)                 # pmap magic!

#' So you can see what just happened, the `dnorm` call explicitly:

dnorm(0.5, mean = 1, sd = 1)
dnorm(0.5, mean = 2, sd = 1)

#' The final fantastic piece is that unwanted combinations
#' can be filtered out using an optional `predicate` function
cross_df(list(mean = 1:3, sd = 1:3), .filter = `==`)    # all combos except equal

# custom predicate
filter <- function(x, y) x > y
cross_df(list(mean = 1:3, sd = 1:3), .filter = filter)  # all combos except x > y

#' An alternative syntax:
seq_len(3) %>%
  list(mean = ., sd = .) %>%
  cross_df(.filter = `==`)

#' An example from SomaR::FeatureSeln
list(fold = paste0("Fold", seq(5)),
     run  = paste0("Run", seq(4))) %>%
  purrr::cross_df() %>%
  purrr::pmap_chr(paste, sep = "_")
