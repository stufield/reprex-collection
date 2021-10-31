
Sys.getenv("SOMADEV_VERSION")
# default library paths
libs <- .libPaths()
libs

# what is there; show on system
fs::dir_ls(libs[1])
fs::dir_ls("~/data/.somadev/0.5.1/Rlib")

# load somaverse
library(somaverse)

# which version palantir?
packageVersion("palantir")

# show  how to  install the "bad" way
# R --vanilla CMD INSTALL palantir

# we want to install newer palantir
?install_sl_bitbucket

# Turn on "analysis mode"
analysis_mode()
# This version of palantir in SLIDE 0.5.2
install_sl_bitbucket("palantir", "v0.1.1", username = "sfield")

# what about Sex & Age models?
palantir::pal_models$sex_plasma    # absent

# need a newer dev version
install_sl_bitbucket("palantir", "ddc8842cf9f", username = "sfield")

# now we have it
palantir::pal_models$sex_plasma

