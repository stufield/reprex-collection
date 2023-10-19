
f <- "~/gh/SomaDataIO/.git/COMMIT_EDITMSG"

f1 <- function(file) {
  n <- 1L
  repeat {
    lines <- readLines(file, n = n, ok = FALSE)
    if ( grepl("^#", lines[n]) ) {
      lines <- lines[-n]
      break
    }
    n <- n + 1L
  }
  lines
}

f2 <- function(file) {
  n <- 1L
  lines <- readLines(file, n = n, ok = FALSE)
  while ( !grepl("^#", lines[n]) ) {
    n     <- n + 1L
    lines <- readLines(file, n = n, ok = FALSE)
  }
  lines[-n]
}

f3 <- function(file) {
  lines <- readLines(file)
  idx   <- grep("^#", lines)[1L] - 1L
  lines[seq(idx)]
}

bench::mark(
  f1 = f1(f),
  f2 = f2(f),
  f3 = f3(f)
)
