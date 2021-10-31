
library(httr)
library(magrittr)

path <- "annotations_graph/api"
url  <- modify_url("https://umbrella.somalogic.io", path = path)

resp <- GET(url)

#resp <- GET(url, add_headers(Name = "somaverse"))
resp <- tryCatch(GET(url, timeout(5)), error = function(x) NULL)

http_type(resp)
warn_for_status(resp)

df <- httr::content(resp, "parsed") %>%
  purrr::pluck("somareagents") %>%
  purrr::transpose() %>%
  tibble::as_tibble() %>%
  tidyr::unnest()

df

