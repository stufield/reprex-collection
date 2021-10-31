
# reprex ----
reprex::reprex({
  options(width = 120)
  library(magrittr)
  library(dplyr)
  library(tibble)
  library(purrr)
  set.seed(101)
  m1 <- lm(mpg ~ ., data = sample_n(mtcars, 20, replace = TRUE))   # train 1
  m2 <- lm(mpg ~ ., data = sample_n(mtcars, 20, replace = TRUE))   # train 2
  m3 <- lm(mpg ~ ., data = sample_n(mtcars, 20, replace = TRUE))   # train 3
  t1 <- select(as_tibble(mtcars), -mpg) %>% sample_n(12, replace = TRUE)      # test 1
  t2 <- select(as_tibble(mtcars), -mpg) %>% sample_n(8, replace = TRUE)      # test 2

  # generate list-tibble of all combinations of data by models
  tbl <- purrr::cross_df(
    list(data = list(t1, t2), models = list(m1, m2, m3))
  )
  tbl

  nest_tbl <- tbl %>%
    mutate(
      pred = map2(models, data, ~ predict(.x, .y)),
      data_id = dplyr::row_number()
    )
  nest_tbl

  nest_tbl %>%
    tidyr::unnest(cols = c(data, pred)) %>% tail()
})




# Aside ----
# n-choose-2 pairwise
purrr::cross_df(list(a = c("Bob", "June"), b = c("Steve", "Mary", "Joe")))

# 3 groups
purrr::cross_df(list(one = c("Bob", "June"),
                     two = c("Steve", "Mary", "Joe"),
                     three = c("Jen", "Carrie")))
