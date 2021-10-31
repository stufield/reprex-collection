
reprex::reprex({
  # Option #1
  library(SomaPlot)
  library(SomaClassify)
  truth <- rep(c("case", "ctrl"), each = 3)
  pred  <- c(0.9, 0.8, 0.7001, 0.7, 0.5, 0.4)
  data.frame(truth, pred)

  xy <- getROCxy(truth, pred, "case")
  xy
  plotROC(xy, pch = 13, cex = 2, lwd = 1, main = "ROC Ties Empirical AUC")
  auc <- calcEmpAUC(truth, pred, "case")
  addText(0.7, 0.6, sprintf("AUC = %0.4f", auc))

  # Option #2
  pred  <- c(0.9, 0.8, 0.7, 0.7001, 0.5, 0.4)
  data.frame(truth, pred)

  xy <- getROCxy(truth, pred, "case")
  xy
  plotROC(xy, pch = 13, cex = 2, lwd = 1, add = TRUE, col = "red")
  auc <- calcEmpAUC(truth, pred, "case")
  addText(0.7, 0.5, sprintf("AUC = %0.4f", auc), col = "red")

  # Option #3
  pred  <- c(0.9, 0.8, 0.7, 0.7, 0.5, 0.4)
  data.frame(truth, pred)

  xy <- getROCxy(truth, pred, "case")
  xy
  plotROC(xy, pch = 13, cex = 2, lwd = 1, add = TRUE, col = "blue")
  auc <- calcEmpAUC(truth, pred, "case")
  calcAUC(truth, pred)
  calcPepeAUC(truth, pred, "case")
  addText(0.7, 0.4, sprintf("AUC = %0.4f", auc), col = "blue")
})
