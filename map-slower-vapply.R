vec <- sample(LETTERS, 10000, replace = TRUE)
listvec <- strsplit(paste(vec, rev(vec)), " ")
bench::mark(
  purrr = purrr::map_chr(listvec, 1L),
  `[`   = vapply(listvec, `[`, i = 1L, ""),
  `[[`  = vapply(listvec, `[[`, i = 1L, "")
)
