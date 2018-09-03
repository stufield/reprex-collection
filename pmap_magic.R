#' Let's just admit it, `purrr::pmap` is awesome!
#' -------------------------
library(purrr)
library(tibble)
set.seed(101)
par_tbl <- tibble(n = seq(5, 25, 5),
                  mean = 1:5,
                  sd = seq(1, 2, length = 5))
par_tbl   # parameters
res <- pmap(par_tbl, rnorm)   # the effin' magic!
res
map_df(res, function(.x)
  tibble(n = length(.x),
         mean = mean(.x),
         sd = sd(.x)))
