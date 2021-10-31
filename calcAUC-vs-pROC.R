
set.seed(2)
n <- 2000
true <- sample(c("control", "disease"), n, replace = TRUE)
pred <- runif(n)
(foo <- bench::mark(
  caTools    = calcAUC(true, pred),
  calcEmpAUC = calcEmpAUC(true, pred, "disease"),
  pROC       = as.double(pROC::roc(true, pred, quiet = TRUE)$auc),
  iterations = 100)
)
summary(foo, relative = TRUE)
