
reprex::reprex({
  library(bench)
  set.seed(101)
  x <- sample(LETTERS, 1e+08, replace = TRUE)
  y <- sample(LETTERS, 1e+08, replace = TRUE)

  bench::mark(
    paste  = paste(x, y, sep = "_"),
    paste0 = paste0(x, "_", y)
  )

  bench::mark(
    paste  = paste(x, collapse = "-"),
    paste0 = paste0(x, collapse = "-")
  )
})
