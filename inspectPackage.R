

inspectPackage <- function(x) {
  pkgs <- tools::package_dependencies(x, recursive = TRUE)[[1L]]
  desc <- packageDescription(x)
  n_auth <- stringr::str_count(desc$`Authors@R`, "role.*aut")
  n_ctb  <- stringr::str_count(desc$`Authors@R`, "role.*ctb")
  tibble::tibble(
    Package = x,
    Version = desc$Version,
    License = desc$License,
    `Recursive Dependencies` = length(pkgs),
    Authors = n_auth,
    Contributors = n_ctb,
  )
}
inspectPackage("dplyr")
inspectPackage("ggrepel")
