#' Great method to separate training/test sets
#' ----------------------
#' This is so elegant yet so simple:
# -------------------------------
library(magrittr)
library(tibble)
suppressMessages(library(dplyr))
mtcars %<>% dplyr::mutate(id = dplyr::row_number())  %>% # set up identifier variable for the join
  tibble::as.tibble()
mtcars

set.seed(1)                               # reproducible

train <- mtcars %>%
  dplyr::sample_frac(size = 0.5)          # random selection of rows @ 50% = 200

test <- mtcars %>%
  dplyr::anti_join(train, by = "id") %>%  # use anti_join to get the sample setdiff
  dplyr::select(-id)                      # remove id

train %<>% dplyr::select(-id)             # remove id

# View the split; pay attention to the `dims`
train

test
