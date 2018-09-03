#' Example of a "Ridgeline" plot via `ggridges`
#' ---------------------------
#' This is pretty cool ...
#' Should be used more often
# ---------------------------------
library(magrittr)
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)
library(ggridges)
set.seed(101)
seq(50, 5, by = -5) %>%
  magrittr::set_names(LETTERS[1:10]) %>%
  map_df(~ rnorm(50, mean = .x, sd = runif(1, 2, 10))) %>%
  gather(key = "Group", value = "value") %>%
  ggplot(aes(x = value, y = Group)) +
    geom_density_ridges(scale = 3, fill = "blue", alpha = 0.5) +
    #scale_x_log10() +
    ggtitle("Cool Density Ridges") +
    theme_ridges() +
    NULL
