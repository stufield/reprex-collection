
library(tidyr)
df <- data.frame(month = rep(1:3, 2),
                 student = rep(c("Amy", "Bob"), each = 3),
                 A = c(9, 7, 6, 8, 6, 9),
                 B = c(6, 7, 8, 5, 6, 7))
df
df %>%
  nest(A, B, .key = "value_col") %>%
  spread(key = student, value = value_col) %>%
  unnest(Amy, Bob, .sep = "_")

library(tidyr)
df <- tibble::tibble(x = c("a", "b"), y = 1:2, z = list(1:2, 3:5))
spread(df, x, y)
