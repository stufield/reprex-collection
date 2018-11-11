#' `tibble::as.tibble` doesn't actually strip rownames, but `dplyr::arrange()` does!
#' -----------------------------------

suppressPackageStartupMessages(library(dplyr))
library(tibble)

df <- data.frame(A = 1:10,
                 B = round(rnorm(10), 2),
                 C = sample(0:1, 10, replace = TRUE),
                 row.names = letters[1:10]
                 )

df

rownames(df)    # has rownames

# convert to a tibble
foo <- as.tibble(df)

# tibble S3 print method ignores rownames
# but `as.tibble()` doesn't actually strip them!
# note: the `*` atop the rownames! It indicates
# the presence of rownames that are being ignored.
foo

# rownames still there
rownames(foo)

# and you can even index with them!
idx <- sample(rownames(df), 4)
idx

# But note that now the rownames are gone for good (no `*`)
foo[ idx, ]


# but `dplyr::arrange()` does remove rownames ... silently!!
bar <- dplyr::arrange(df, B)
rownames(bar)

# workaround for `data.frames`
# not necessary for `soma.adat` objects
bar <- df %>%
  rownames_to_column() %>%
  dplyr::arrange(B) %>%
  column_to_rownames()
rownames(bar)
