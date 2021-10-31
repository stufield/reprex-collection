vec <- sample(LETTERS, 10000, replace = TRUE)
vec <- paste0(vec, "-", rev(vec))
f1 <- function() {
  purrr::map_chr(strsplit(vec, "-", fixed = TRUE), 1L)
}
f2 <- function() {
  vapply(strsplit(vec, "-", fixed = TRUE), `[`, i = 1L, "")
}
f3 <- function() {
  vapply(strsplit(vec, "-", fixed = TRUE), `[[`, i = 1L, "")
}
bench::mark(purrr = f1(), `[` = f2(), `[[` = f3())

