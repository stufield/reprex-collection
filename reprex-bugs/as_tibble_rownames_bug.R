#` Tibble issue with rownames passed

reprex::reprex({
  library(tibble)
  packageVersion("tibble")
  library(magrittr)
  df <- data.frame(V = letters[1:5])
  df
  rownames(df)

  # Error thrown
  df %>% as_tibble(rownames = "num_char")

  # If you explicetly generate rownames for `df`
  # It `as_tibble() proceeds as expected
  rownames(df) <- as.character(1:5)
  rownames(df)

  # No error thrown
  df %>% as_tibble(rownames = "num_char")
})
