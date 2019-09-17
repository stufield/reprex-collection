library(magrittr)
library(purrr)
library(bench)
set.seed(1)
x <- replicate(100, rnorm(sample(50:500, 1))) %>%
  map(~ {.x[sample(1:length(.x), 3)] <- NA; .x})

bnch <- bench::mark(
  Filter_Negate     = map(x, Filter, f = Negate(is.na)),
  is.na             = map(x, ~ .x[!is.na(.x)]),
  `purrr::discard`  = map(x, purrr::discard, .p = is.na),
  `purrr::discard2` = map(x, ~ purrr::discard(.x, .p = is.na)),
  iterations = 250
)

bnch

summary(bnch, relative = TRUE)
