
reprex::reprex({
  library(magrittr)
  library(tibble)
  library(tidyr)
  library(purrr)
  x <- list(1, c(2, 3, 4), 5)
  y <- 1:3

  f1 <- function(x, y) {
    cbind(x = unlist(x), y = rep(y, lengths(x)))
  }
  f2 <- function(x, y) {
    map2(x, y, ~ {
      cbind(x = .x, y = rep(.y, length(.x)))
    }) %>% do.call(rbind, .)
  }
  f3 <- function(x, y) {
    tibble(x, y) %>% unnest(cols = c("x")) %>% as.matrix()
  }
  bench::mark(
    base = f1(x, y),
    purrr = f2(x, y),
    tidyr = f3(x, y)
  )
  bench::mark(
    base = f1(x, y),
    purrr = f2(x, y),
    tidyr = f3(x, y),
    relative = TRUE
  )
})



reprex::reprex({

  df <- data.frame(a = 1:5,
                   b = 1:5,
                   c = 1:5)
  ratio <- 1:3

  f1 <- function(x) {
    data.frame(t(t(x) * ratio))
  }

  f2 <- function(x) {
    data.frame(purrr::map2(x, ratio, ~ .x * .y))
  }

  bench::mark(
    base = f1(df),
    tidy = f2(df)
  )
})
