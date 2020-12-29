
reprex::reprex({
  suppressMessages(library(dplyr))
  library(purrr)
  library(bench)
  library(tibble)
  set.seed(101)

  # Create tibble with `n` columns, each with 100 Gaussian mean = 100
  # Name p1 -> p_n
  n  <- 2500
  df <- rerun(n, rnorm(100, mean = 100)) %>%
    as_tibble(.name_repair = "minimal") %>%
    set_names(paste0("p", 1:ncol(.)))

  subset <- paste0("p", sample(1:n, n/2)) # random half of columns

  # a function to pass to `mutate_at()`
  # ratio to entry[1]
  ratio <- function(x) x / x[1L]

  # Use the bench pkg to compare
  # base `apply()` to `mutate_at()`
  bnch <- mark(
    base_apply = { df[, subset] <- apply(df[, subset], 2, ratio); df },
    dplyr_mutate_at = { mutate_at(df, subset, ratio) }
  )

  # Absolute differences
  bnch

  # Relative differences
  summary(bnch, relative = TRUE)
})
