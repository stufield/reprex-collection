reprex::reprex({
  library(MASS)
  packageVersion("MASS")
  n <- 3
  set.seed(1)
  mvrnorm(n, mu = rep(10, n), Sigma = diag(n), empirical = TRUE)
})
