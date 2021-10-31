#' R User Group: Episode #1
#' --------------------------

#' The 'somaverse'
#' ----------------
n_packages    <- 21
core_pkgs     <- c("SomaReadr", "SomaPlyr", "SomaGlobals", "SomaPlot", "SomaPCA",
                   "SomaClassify", "SomaSurvival", "SomaDB",
                   "SomaStabilitySelection", "SomaNormalization")
satellites      <- 11    # SomaPipeline SomaFeatureSelect SomaCluster
somaverse_pkg   <- "tidyverse clone"
somaverse_html  <- "http://confluence.sladmin.com/display/BITOOLS/The+somaverse"

# -------------
# Style ----
# -----------
why_style       <- "https://twitter.com/WeAreRLadies/status/1159353720028717056"
somaverse_style <- TRUE
somaverse_lintr <- TRUE
isTRUE(all.equal("tidyverse", "somaverse"))


#' Why use the 'L'?
#' ----------------
vec <- c("Bob", cool ="Tina", hot = "Carl", "Betty")
vec[2]
vec[2L]
class(2)
class(2L)
vec[2.341]
vec[2.99999999999999999999]
floor(2.341)


#' The factor class and c()
#' ----------------
a <- factor(c("colorado", "idaho"))
b <- factor(c("idaho", "alabama"))

# What will result and why?
c(a, b)

#' Namespace Isolation
#' ----------------
file <- "namespace_isolation.R"
