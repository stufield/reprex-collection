
reprex::reprex({
  library(purrr)
  library(bench)
  set.seed(101)
  n   <- 10000
  x   <- runif(n, min = -500, 6000)
  sex <- sample(c("M", "F"), n, replace = TRUE)

  # base R
  f1 <- function(x, sex) {
    idx_m <- which(x > 5670 & sex == "M")
    idx_f <- which(x > 4082 & sex == "F")
    x[idx_m] <- 5670
    x[idx_f] <- 4082
    x[x < 225] <- 225
    x
  }

  # tidyverse purrr
  f2 <- function(x, sex) {
    purrr::map2_dbl(x, sex, ~ {
      if ( .x > 5670 & .y == "M" ) {
        5670
      } else if ( .x > 4082 & .y == "F" ) {
        4082
      } else {
        max(.x, 225)
      }
    })
  }

  # benchmarking
  bench::mark(one = f1(x, sex), two = f2(x, sex))

  # relative bench
  bench::mark(one = f1(x, sex), two = f2(x, sex), relative = TRUE)
})
