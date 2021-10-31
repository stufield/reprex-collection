
reprex::reprex({
  library(recipes)
  packageVersion("recipes")

  rec <- recipe(Species ~ ., data = iris) %>%
    step_center(all_predictors()) %>%
    step_scale(all_predictors()) %>%
    prep()

  # last_term_info req'd recipes '0.1.15'
  # but not req'd '0.1.10'
  rec$last_term_info <- NULL
  bake(rec, iris)
})


reprex::reprex({
  library(palantir)
  packageVersion("recipes")
  rec <- pal_recipes$egfr
  rec$last_term_info <- NULL   # element missing in the final recipe
  new <- log10(addClass(verification_data$egfr, "soma_adat"))
  recipes::bake(rec, new)
})


foo <- pal_recipes$egfr
foo$last_term_info <- dplyr::arrange(foo$var_info, variable)
foo$last_term_info$number <- 3
foo$last_term_info$skip <- FALSE

new <- log10(mock_adat(verification_data$egfr))
recipes::bake(pal_recipes$egfr, new)
recipes::bake(foo, new)

all(sapply(palantir::pal_recipes, function(x) "last_term_info" %in% names(x)))

