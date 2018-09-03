#' Generate side-by-side plots using `ggplot2` and `gridExtra`
#' ---------------------
#' Found this useful:
#'
#'   1. Save individual ggplot2 objects in a list object
#'   2. Send list as argument to `do.call` or `purrr::invoke` with`gridExtra::grid.arrange`
# ------------------
library(ggplot2)
library(gridExtra)
library(purrr)
n <- 100
purrr::map(c(1,-1), ~ {           # 2 plots
  data.frame(x = seq(n),
             y = .x * seq(n) + stats::rnorm(n, sd = 8)) %>%
    ggplot(aes(x=x, y=y)) +
      geom_point(alpha = 0.25) +
      geom_jitter(width = 0.1) +
      geom_smooth(method = 'loess') +
      NULL
  }) %>%
  purrr::invoke(gridExtra::grid.arrange, ., ncol = 2)
