
library(bench)
set.seed(101)
a <- sample(LETTERS, 10000, replace = TRUE)
b <- sample(LETTERS, 1000, replace = TRUE)
foo <- bench::mark(
  paste      = paste(a, b, sep = ""),
  paste0     = paste0(a, b),
  iterations = 1000
)

foo

summary(foo, relative = TRUE)
