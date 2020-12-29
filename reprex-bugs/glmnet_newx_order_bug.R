
#' There appears to be a bug in `glmnet::glmnet.predict()` where the 'newx='
#' test data *must* be in the SAME order as the training set (or in the model)
#' This did not use to be the case in previous versions of `glmnet`
reprex::reprex({
  library(magrittr)
  library(dplyr)
  library(glmnet)

  # training data
  train <- mtcars %>%
    select(mpg, disp, hp, cyl) %>%   # select 3 feature model
    mutate_at(vars(disp, hp), ~ {
      log10(.x) %>% subtract(mean(.)) %>% divide_by(sd(.))   # center & scale
    }) %>% as.matrix()
  head(train)

  # fit glmnet model
  model <- glmnet(train[, 2:4], train[, "mpg"], lambda = 1)

  # jitter test data + reduce
  test  <- jitter(train[, 2:4], amount = 0.1) %>% head()

  # output differs when `newx=` feature order differs!
  data.frame(
    mpg          = head(train[, "mpg"]),                        # truth
    pred_orig1   = as.numeric(predict(model, newx = test)),     # same order
    pred_orig2   = as.numeric(predict(model, newx = test[, c("disp", "hp", "cyl")])), # same order
    pred_reorder = as.numeric(predict(model, newx = test[, c("cyl", "disp", "hp")]))  # re-order
    )
})

