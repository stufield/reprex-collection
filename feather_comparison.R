
reprex::reprex({
  library(magrittr)
  library(SomaObjects)
  library(tibble)
  library(feather)
  t_feather <- purrr::map_dbl(1:10, ~ {
    t <- Sys.time()
    write_feather(SurvData, "/tmp/surv.feather")
    as.numeric(Sys.time() - t)
  }) %>% mean()

  t_base <- purrr::map_dbl(1:10, ~ {
    t <- Sys.time()
    saveRDS(SurvData, file = "/tmp/surv.rds")
    as.numeric(Sys.time() - t)
  }) %>% mean()

  s_feather <- file.info("/tmp/surv.feather")$size / 1024^2
  s_base <- file.info("/tmp/surv.rds")$size / 1024^2

  tibble(
    package = c("base", "feather"),
    avg_time = c(t_base, t_feather),
    size = c(s_base, s_feather)
  )
})
