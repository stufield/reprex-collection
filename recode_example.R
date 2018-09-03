
#' `dplyr::recode` Bug
#' -----------
#' Dynamic programming of factors
#' using quasi-qotation doesn't work with recode_factor

library(magrittr)
library(dplyr)
library(tidyr)
set.seed(100)
x <- sample(head(LETTERS, 3), 10, replace = TRUE) %>% factor
x
level_key <- list("Be", "Cool", "Amigo") %>% set_names(c("B", "C", "A"))
level_key   # reorder in desired levels
dplyr::recode(x, !!!level_key)        # no re-leveling; desired B C A; try recode_factor()
dplyr::recode_factor(x, B = "Be", C = "Cool", A = "Amigo")
dplyr::recode_factor(x, !!!level_key) # error with recode_factor :(
