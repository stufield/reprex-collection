
# Data setup
set.seed(101)
a <- data.frame(true = rep("control", 50))
b <- data.frame(true = rep("disease", 50))
a$pred <- rnorm(50, mean = 0.38, sd = 0.4)
b$pred <- rnorm(50, mean = 0.66, sd = 0.73)
df <- rbind(a, b)
plotEmpROC(df$true, df$pred, pos.class = "disease", cutoff = 0.8)

# Summary of confusion matrix
c_mat <- calc_confusion(df$true, df$pred, pos.class = "disease", cutoff = 0.5)
class(c_mat)

s_mat <- summary(c_mat)
class(s_mat)
s_mat

# Arguments
args(getStat)

# Arg matching
getStat(s_mat, "Sens")
getStat(s_mat, "Spec")
getStat(s_mat, "Acc")
getStat(s_mat, "NPV")
getStat(s_mat, "PPV")
