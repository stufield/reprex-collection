
suppressMessages(library(SomaPlyr))
library(survival)
data <- log10(SomaGlobals::sim_test_data) %>%
  dplyr::mutate(
    class_response = ifelse(class_response == "disease", "Y", "N") %>%
      factor(levels = c("Y", "N"))
  )
feats <- SomaPlyr::getAptamers(data)
mysurvformula <- stringr::str_glue(
  "survival::Surv(time, status) ~ {rhs}",
  rhs = paste(feats, collapse = "+")) %>%
  stats::as.formula()
fitsurvreg <- survival::survreg(mysurvformula, data = data)

# replicate 1st sample 50x
new <- dplyr::sample_n(head(data, 1), 50, replace = TRUE)

# floating point differences between
# SLIDE and Desktop
options(digits = 16)
predict(fitsurvreg, new) %>% table()
