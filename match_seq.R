library(Rcpp)
library(purrr)
library(stringr)
library(bench)

# Helper function to both functions
# Extracts the SeqId portion of a string & replaces the "." -> "-"
getSeqId <- function(x) {
  x         <- stringr::str_trim(x)   # zap whitespace
  match_mat <- stringr::str_locate(x, "[0-9]{4,5}[-.][0-9]{1,3}([._][0-9]{1,3})?$")
  args <- list(string = x,
               start  = match_mat[, "start"],
               end    = match_mat[, "end"])
  purrr::pmap_chr(args, stringr::str_sub) %>%
    stringr::str_replace("\\.", "-")
}

# The C++ version of matchSeqIds
Rcpp::cppFunction('
  #include <Rcpp.h>
  #include <unordered_map>
  Rcpp::StringVector
    matchseq_cpp(CharacterVector x,          // string containing SeqId entries //
                 CharacterVector y,          // string containing SeqIds to match x //
                 bool order_by_x = true) {   // logical on ordering //
    Function base_intersect("intersect");    // cannot use sugar; order differs; small speed cost tho //
    Function getSeqId("getSeqId");           // get function from outside //
    CharacterVector x_seqs = getSeqId(x);    // get SeqIds; non-seqs are NA //
    x_seqs = Rcpp::na_omit(x_seqs);          // rm NAs //
    CharacterVector y_seqs = getSeqId(y);    // get SeqIds from y //
    int L = y.size();
    std::unordered_map< std::string, std::string > hashmap; // initialize hashmap //
    for(int i = 0; i < L; i++) {
      hashmap.insert(std::make_pair(y_seqs[i], y[i]));  // populate hashmap //
    }
    CharacterVector ord_seqs(L);                  // initiate vector for intersect //
    if (order_by_x) {
      ord_seqs = base_intersect(x_seqs, y_seqs);  // get SeqId intersection of x & y //
    } else {
      ord_seqs = base_intersect(y_seqs, x_seqs);  // get SeqId intersection of y & x //
    }
    int n = ord_seqs.size();
    Rcpp::StringVector res(n);
    for(int j = 0; j < n; j++) {
      // get the corresponding y values   //
      res[j] = hashmap[ Rcpp::as< std::string >(ord_seqs[j]) ];
    }
    return res;
  }'
)

# The original matchSeqIds
# A Seqid is of this form: XYZ.1234.56 or XYZ-1234_45
# Match on the SeqId portion; NOT the preceeding ":alpha:" string
matchSeqIds <- function(x, y, order.by.x = TRUE) {
  x_seqIds <- getSeqId(x) %>% purrr::discard(is.na)
  # create lookup table to index SeqIds to their values in 'y'
  y_lookup <- as.list(y) %>% purrr::set_names(getSeqId(y))
  y_seqIds <- names(y_lookup) %>% purrr::discard(is.na)   # rm NAs in 'y'
  if ( order.by.x ) {
    order_seqs <- intersect(x_seqIds, y_seqIds)
  } else {
    order_seqs <- intersect(y_seqIds, x_seqIds)
  }
  if ( length(order_seqs) == 0 ) {
    return(character(0))
  }
  purrr::map_chr(order_seqs, ~ y_lookup[[.x]])
}


# Generate a dummy long string of combined SeqIds
set.seed(101)
n    <- 5000
gene <- replicate(n, paste0(sample(LETTERS, 4, replace = TRUE), collapse = ""))
x    <- paste0(gene, ".", sample(1:15000, n), ".", sample(1:999, n, replace = TRUE))

# sample 10 from x and modify the GeneID
# so that full matches can't be done
# must match based on SeqId
y <- sample(x, 2500)       # almost all of 'x' but still a subset
y <- paste0(sample(LETTERS, n, replace = TRUE), y)

# Benchmark
bnch <- bench::mark(
  matchseq_cpp    = matchseq_cpp(x, y),
  matchSeqIds     = matchSeqIds(x, y),
  iterations      = 100
)

# Absolute
# Only ~ 2x improvement
# Longer 'y' results in > improvement (more matching to do)
bnch

# Relative
summary(bnch, relative = TRUE)
