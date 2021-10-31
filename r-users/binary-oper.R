

# What is a binary operator?

## Any function with 2 parameters that can be seen as a LHS and RHS

`%in%`
`+`
magrittr::`%>%`

# examples
head(LETTERS) %in% c("A", "C")
4 + 7
`+`(4, 7)

# dummy example
`%paste-coll%` <- function(x, y) {
  x <- paste(stringr::str_squish(x), collapse = " ")
  y <- paste(stringr::str_squish(y), collapse = " ")
  paste(x, "+", y)
}

c("dog", "cat", "mouse") %paste-coll% c("dragon", "kraken")

# a more practical example
`%~~%` <- function(x, y) {
  bool <- isTRUE(all.equal(x, y))
  if ( bool ) {
    bool
  } else {
    #waldo::compare(x, y)
    SomaReadr::diffAdats(x, y)
  }
}

poc_data %~~% a
