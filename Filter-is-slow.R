library(purrr)
x <- withr::with_seed(1, replicate(100, rnorm(sample(50:500, 1))))
L <- lengths(x)
x <- mapply(x, L, FUN = function(.x, .y) {
  .x[sample(seq(.y), 3L)] <- NA_real_
  .x
})

bnch <- bench::mark(
  Filter_Negate    = lapply(x, Filter, f = Negate(is.na)),
  `[`              = lapply(x, function(.x) .x[!is.na(.x)]),
  `purrr::discard` = lapply(x, purrr::discard, .p = is.na)
)

bnch
summary(bnch, relative = TRUE)
