
inspectPackage <- function(x) {
  stopifnot(is.character(x), length(x) > 0L)
  names(x) <- x
  ret <- lapply(x, function(.x) {
    desc <- packageDescription(.x)
    dep  <- gsub("[[:space:]]+", " ", trimws(strsplit(desc$Depends, ",")[[1L]]))
    imp  <- gsub("[[:space:]]+", " ", trimws(strsplit(desc$Imports, ",")[[1L]]))
    period <- paste0("2014-11-09:", Sys.Date() - 1) # all time
    down <- httr::GET(url = sprintf("https://cranlogs.r-pkg.org/downloads/total/%s/%s",
                                    period, .x)) |>
      httr::content("parsed", encoding = "UTF-8") |> unlist()

    tibble::tibble(
      Version = desc$Version,
      License = desc$License,
      dependencies = length(imp) + length(dep),
      Recursive_dependencies = length(tools::package_dependencies(.x, recursive = TRUE)[[1L]]),
      downloads = prettyNum(down["downloads"], big.mark = ","),
      Authors = length(grep("role.*aut", unlist(strsplit(desc$Authors, "\n")))),
      Contributors = length(grep("role.*ctb", unlist(strsplit(desc$Authors, "\n"))))
    )
  })
  dplyr::bind_rows(ret, .id = "Package")
}
inspectPackage(c("dplyr", "ggrepel"))
