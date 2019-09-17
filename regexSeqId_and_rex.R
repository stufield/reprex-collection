library(SomaReadr)
library(bench)

regexSeqId2 <- function() {
  rex::rex(
    between(digit, 4, 5),        # SeqId; 4-5 numeric digits
    "-" %or% dot,                # either "-" or "."
    between(digit, 1, 3),        # Clone;  1-3 numeric digits
    maybe(
      "_" %or% dot,              # either "_" or "."
      between(digit, 1, 3)       # optional Version; 1-3 numeric digits
    ),
    end
  )
}

set.seed(101)
x  <- sample(names(sample.adat), 1000000, replace = TRUE)
bn <- mark(
  orig = grep(regexSeqId(), x),
  rex  = grep(regexSeqId2(), x),
  iterations = 100
)

bn

summary(bn, relative = TRUE)
