
reprex::reprex({
  library(SomaNormalization)
  library(bench)
  options(width = 120)
  set.seed(100)
  test <- system.file("medianNorm_references",
                      "Population_Reference_V4_Covance_plasma.rds",
                      package = "SomaNormalization", mustWork = TRUE) %>%
    readRDS() %>%
    filter(SITE_ID == "Boise" & BMI < 30) %>%
    select(SampleType, SampleMatrix, SlideId, Subarray, SampleId, SampleGroup,
           getNormNames(.), sample(getAptamers(.), 500))

  dim(test)

  bnch <- mark(
    orig_ssDAMN = singleSampleDAMN(test),                       # original
    cpp_ssDAMN  = SomaNormalization:::singleSampleDAMN2(test)   # uses Rcpp
  )

  # Absolute differences
  bnch

  # Relative differences
  summary(bnch, relative = TRUE)
})
