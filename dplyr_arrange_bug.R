
df <- data.frame(a = letters, b = 26:1)
class(df) <- c("my_class", class(df))
head(df, 3)
class(df)
new <- dplyr::arrange(df, b)
class(new)
