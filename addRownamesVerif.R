
addRownamesVerif <- function(file) {
  read.table(file, sep = "\t", header = TRUE) %>%
    write.table(file = file, sep = "\t", quote = FALSE, row.names = 1:nrow(.))
  invisible(NULL)
}
