
library(magrittr)
library(tibble)
library(purrr)
library(SomaObjects)
foo <- function(adat, ...) {
  apts <- SomaPlyr::getAptamers(adat)
  purrr::map2_df(apts, list(...), function(apt, dots) {
    stringr::str_c(apt, "_____", dots) %>%
      tibble() %>%
      magrittr::set_names("AptDots")
  })
}
foo(SomaObjects::test_data, new = 911)
