
suppressMessages(library(SomaDataIO))
library(survival)

data <- log10(splyr::sim_adat) |>
  dplyr::mutate(
    class_response = ifelse(class_response == "disease", "Y", "N") |>
      factor(levels = c("Y", "N"))
  )
feats <- getAnalytes(data)
mysurvformula <- stringr::str_glue(
  "survival::Surv(time, status) ~ {rhs}",
  rhs = paste(feats, collapse = "+")) |>
  stats::as.formula()

fitsurvreg <- survival::survreg(mysurvformula, data = data)

# replicate 1st sample 50x
new <- dplyr::sample_n(head(data, 1), 50, replace = TRUE)

# floating point differences between SLIDE-ENV and Desktop
options(digits = 16L)
predict(fitsurvreg, new) |> table()
