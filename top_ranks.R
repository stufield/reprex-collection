# helper
# returns logical vector for `filter()`
top_ranks <- function(n, ...) {
  enq <- rlang::enquos(...)
  sapply(enq, function(.x)  {
    dplyr::min_rank(desc(rlang::eval_tidy(.x))) <= n
  }) %>% apply(1, any)
}

# Usage:
# choose any number of columns to query
# n must be same for all
mtcars %>%
  tibble::rownames_to_column("Model") %>%    # `filter()` rm rownames of df
  dplyr::filter(top_ranks(5, mpg))
mtcars %>%
  tibble::rownames_to_column("Model") %>%
  dplyr::filter(top_ranks(5, mpg, hp))
mtcars %>%
  tibble::rownames_to_column("Model") %>%
  dplyr::filter(top_ranks(5, mpg, hp, wt))

