library(lubridate)
library(RColorBrewer)
library(dplyr)
library(tidyverse)
library(ggplot2)

# Grab data from https://covidtracking.com/api/states/daily.csv
dt <- read.csv("https://covidtracking.com/api/states/daily.csv")
dt$date <- as.Date(trunc(strptime(dt$dateChecked,
                                  format = "%Y-%m-%d", tz = "EST"), "day"))

dt <- as_tibble(dt)
dt <- dt %>%
  group_by(date, state) %>%
  mutate(test_pos = positive / (positive + negative),
         test_neg = negative / (positive + negative),
         tests    = (positive + negative))
co <- dt %>%
  ungroup() %>%
  dplyr::filter(state == "CO")  # set a horizontal line for your state of reference

gg <- ggplot(dt, aes(x = date, y = tests, size = test_pos, color = state)) +
  geom_point() +
  scale_y_continuous(trans = "log10") +
  geom_hline(yintercept = (co$positive[1L] + co$negative[1L]), linetype = "dashed", color = "red") +
  facet_wrap(~state, ncol = 8) +
  scale_size_continuous(name = "% test positive") +
  ylab("Cumulative tests conducted")

gg

co <- dt %>%
  ungroup() %>%
  dplyr::filter(state == "CO")
co$positive[1] + co$negative[1]
