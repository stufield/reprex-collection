
reprex::reprex({
  library(fs)
  # the $HOME
  path_abs("~/")      # does not expand path
  path_expand("~/")   # expands $HOME path
  path_real("~/")     # expands $HOME path

  # a complex path
  dir <- "~/bitbucket/SomaReadr/../palantir/"   # modify 4 ur system
  path_expand(dir)    # doesn't resolve path
  path_abs(dir)       # doesn't expand path
  path_real(dir)      # resolves and expands path
})
