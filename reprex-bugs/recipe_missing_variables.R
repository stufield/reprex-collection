reprex::reprex({
  options(width = 100)
  library(dplyr)
  library(tibble)
  library(recipes)
  set.seed(1)                               # reproducible
  packageVersion("recipes")

  #' Setup: create binary class data
  data <- iris %>%
    filter(Species != "versicolor") %>%   # binary; rm 1 class
    mutate(id = row_number())  %>%   # set up temp variable for the join
    as_tibble()

  train <- data %>% sample_frac(size = 0.8)  # random selection of rows @ 80%

  test <- data %>%
    anti_join(train, by = "id") %>%  # use anti_join to get the sample setdiff
    select(-id)                      # remove id

  train <- dplyr::select(train, -id)      # rm id

  #' Create simple recipe: center, scale
  recp <- recipe(Species ~ ., data = train) %>%
    step_center(all_predictors()) %>%
    step_scale(all_predictors()) %>%
    prep(training = train)

  train <- bake(recp, new_data = train)
  names(train)

  #' Future test set may have additional sample information we want to track
  #' that were unrelated to the training set
  test <- test %>%
    mutate(
      pid = sample(1:nrow(.)),
      state = sample(c("CO", "WY", "NY", "LA"), nrow(.), replace = TRUE),
      diabetes = sample(c("Y", "N"), nrow(.), replace = TRUE)
    )
  head(test, 10)

  #' Pre-process the "new" test data set
  test_prep <- bake(recp, new_data = test)

  #' pid, state, and diabetes missing following data prep/baking
  #' because they were not present in the original training recipe
  head(test_prep, 10)

  #' Workaround; simply bind the variables back on after baking;
  #' Not ideal, could be error prone, breaks 'tidy' data frame philosophy
  bind_cols(test_prep, select(test, pid, state, diabetes)) %>% head(10)
})
