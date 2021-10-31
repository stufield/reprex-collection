
add_recipe_var <- function(rcp, var, type = c(NA, "nominal", "numeric", "logical"),
                           role = NA, source = "original") {

  if ( !inherits(rcp, "recipe") ) {
    usethis::ui_stop("'rcp' argument must be a `recipe` object")
  }

  type <- match.arg(type)

  # Make sure type is correctly formatted
  if ( is.na(type) ) {
    usethis::ui_stop(
      "'type' argument must be one of: 'nominal', 'numeric', or 'logical'"
    )
  }
  
  nms <- c("variable", "type", "role", "source")

  if ( !var %in% rcp$var_info$variable ) {
    rcp$var_info <- dplyr::bind_rows(
      rcp$var_info, setNames(c(var, type, role, source), nms)
    )
  }
  if ( !var %in% rcp$term_info$variable ) {
    rcp$term_info <- dplyr::bind_rows(
      rcp$term_info, setNames(c(var, type, role, source), nms)
    )
  }
  return(rcp)
}
