#' Cautionary tale with `which` and `NAs`
#' -----------------------------------------
#' Issue came up with Yolanda/Leigh with `which` and `NAs`
#' getting incorrect indices
x <- c(rep("A", 4), rep(NA_character_, 4))
x

length(x)     # 8 records total
x != "A"      # NAs return NA in the boolean vector

which(x == "A")    # this is fine
which(x != "A")    # this is not
