
reprex::reprex({
  library(dplyr)
  library(tidyr)
  library(tibble)
  #' Unexpected result calling `tidyr::nest(-gear)` if upstream `dplyr::group_by(cyl)`.
  df <- as_tibble(mtcars) %>%
    group_by(cyl)

  group_vars(df)

  #' The grouping variable (cyl) over-rides user-defined nesting variable (gear).
  #' Additionally, 'gear' is removed from the 'data' tibbles.
  ndf <- nest(df, -gear)
  ndf

  # gear disappears completely!
  "gear" %in% names(ndf)
  "gear" %in% names(ndf$data)

  #' Expected result (compare tibble dims to those above):
  df %>%
    ungroup(mtcars) %>%    # remove group_var: cyl
    nest(-gear)
})

reprex::reprex({
  library(dplyr)
  library(tidyr)
  library(tibble)
  #' Assume you used dplyr::group_by() upstream, forgot to
  #' ungroup and then wanted to tidyr::nest() on `gear`:
  df <- mtcars %>%
    as_tibble() %>%
    group_by(cyl) %>%
    nest(-gear)
  df

  "cyl" %in% names(df)

  #' As expected, `gear` is dropped from the nested data frames under `data`:
  names(df$data[[1]])   # no `gear` variable ... as expected

  #' However, it is *not* part of the nesting structure of `df`:
  "gear" %in% names(df)

  #' I *think* this is what I would expect:
  mtcars %>%
    as_tibble() %>%
    nest(-cyl, -gear)
})
