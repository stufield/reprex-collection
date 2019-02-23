
#' Working with nested tibbles as list columns
#' --------------
#' Example from Hadley about `nest()` and `unnest()`

suppressMessages(library(dplyr))
library(tidyr)
library(purrr)
library(broom)
library(gapminder)

by_country <- gapminder %>%
  nest(-country) %>%
  mutate(
    model = map(data, ~ stats::lm(lifeExp ~ year, data = .x)),
    br_glance = map(model, glance),
    br_tidy = map(model, tidy),
    br_augment = map(model, augment)
  )

by_country

by_country %>% unnest(br_glance)

by_country %>% unnest(br_tidy)

by_country %>% unnest(br_augment)
