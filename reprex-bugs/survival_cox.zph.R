
reprex::reprex({
  RNGkind(sample.kind = "Rounding")  # R version consistency
  set.seed(101)
  n    <- 50
  data <- data.frame(
    time   = rexp(n),
    status = rbinom(n, 1, prob = 0.7),
    A      = rnorm(n),
    B      = rnorm(n),
    C      = rnorm(n)
  )
  fit <- survival::coxph(survival::Surv(time, status) ~ ., data)
  fit
  survival::cox.zph(fit)
})
