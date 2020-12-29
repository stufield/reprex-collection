
# There appears to be a glmnet::glmnet() difference in Cox family model
# between glmnet 2.0.16 (R 3.5.x) vs glmnet 3.0.2 (R 3.6.x)
reprex::reprex({
  library(magrittr)
  library(dplyr)
  library(glmnet)
  dat <- mtcars %>%
    select(mpg, disp, status = vs, time = hp) %>%   # select 2 features; assign time & status
    mutate_at(1:2, ~ {
      log10(.x) %>% subtract(mean(.)) %>% divide_by(sd(.))   # center & scale
    }) %>% as.matrix()
  glmnet(dat[, 1:2], dat[, 3:4], family = "cox", lambda = 0)$beta   # fit model
})


reprex::reprex({
  library(magrittr)
  n   <- 5
  dat <- SomaSurvival::SurvData %>%
    dplyr::select(seq.10006.25, seq.10008.43, time, status = event) %>%
    dplyr::mutate_at(1:2, ~ {
      log10(.x) %>% subtract(mean(.)) %>% divide_by(sd(.))
    }) %>%
    split(rep(1:n, each = ceiling(nrow(.) / n), length.out = nrow(.)))
  purrr::map_df(dat, ~ {
    .x %<>% as.matrix() %>% round(3)
    glmnet::glmnet(.x[, 1:2], .x[, 3:4], family = "cox", lambda = 0)$beta %>%
      as.numeric() %>% sum() %>%
      data.frame(n = nrow(.x), beta = .)
  })
})

