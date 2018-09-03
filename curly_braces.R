library(magrittr)
set.seed(101)
stu <- purrr::map(1:4, function(.x) sample(LETTERS, 5)) %>%
  set_names(head(LETTERS, 4))
stu

# Curly braces solves the issue, but
# This gives the wrong answer for some reason
LETTERS %>%
  head(10) %>% {
  purrr::map_dfc(stu, ~as.numeric(. %in% .x))
}

# This is what we want
LETTERS %>%
  head(10) %>% {
  purrr::map_dfc(stu, function(.x) as.numeric(. %in% .x))
}
