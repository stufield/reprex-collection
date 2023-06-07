
reprex::reprex({
  vec <- 1:3L
  x <- purrr::cross_df(list(x = vec, y = vec))
  y <- dplyr::arrange(tidyr::expand_grid(x = vec, y = vec), y)  # re-orders
  z <- expand.grid(x = vec, y = vec, KEEP.OUT.ATTRS = FALSE,
                   stringsAsFactors = FALSE) |> tibble::as_tibble()
  x
  isTRUE(all.equal(x, y)) # ensure same output
  isTRUE(all.equal(y, z))

  # tidyverse is much slower!
  bench::mark(
    purrr = purrr::cross_df(list(x = vec, y = vec)),
    tidyr = dplyr::arrange(tidyr::expand_grid(x = vec, y = vec), y),
    base  = tibble::as_tibble(
              expand.grid(x = vec, y = vec, KEEP.OUT.ATTRS = FALSE,
                          stringsAsFactors = TRUE))
  )
})
