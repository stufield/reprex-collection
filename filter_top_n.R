#' Very cool `filter_top_n` function
#' --------------------
#' Pretty neat application of `dplyr::row_number`
#' in combination with `dplyr::group_by`
#' allowing for filtering the top `n` values per group
library(tibble)
suppressMessages(library(dplyr))

data <- tibble(value = 1:100,
               group = rep(LETTERS[1:10], each = 10)
               )
data

filter_top_n <- function(x, n, group.var) {

  x %>%
    group_by(!!dplyr::sym(group.var)) %>%
    mutate(gr_nr = row_number()) %>%
    ungroup() %>%
    filter(gr_nr <= n) %>%
    select(-gr_nr)
}

# Get the top 3 records from each group
filter_top_n(data, 3, "group")
