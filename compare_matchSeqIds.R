
reprex::reprex({
  library(Rcpp)
  library(purrr)
  library(bench)
  library(SomaReadr)
  library(SomaPlyr)
  matchSeqIds <- function(x, y, order.by.x = TRUE) {
    x_seqIds <- getSeqId(x, TRUE) %>% discard(is.na)
    y_lookup <- as.list(y) %>% set_names(getSeqId(y, TRUE))
    y_seqIds <- names(y_lookup) %>% discard(is.na)
    if ( order.by.x ) {
      order_seqs <- intersect(x_seqIds, y_seqIds)
    } else {
      order_seqs <- intersect(y_seqIds, x_seqIds)
    }
    if ( length(order_seqs) == 0 ) {
      return(character(0))
    }
    map_chr(order_seqs, ~ y_lookup[[.x]])
  }
  matchSeqIds_old <- function(x, y, order.by.x = TRUE) {
    x <- getAptamers(x)
    y <- getAptamers(y)
    x_seqIds <- getSeqId(x, trim.version = TRUE)
    y_seqIds <- getSeqId(y, trim.version = TRUE)
    if ( order.by.x ) {
      order_list <- intersect(x_seqIds, y_seqIds)
    } else {
      order_list <- intersect(y_seqIds, x_seqIds)
    }
    if ( length(order_list) == 0 ) {
      return(character(0))
    }
    new.list <- character(0)
    for ( seq_id in order_list ) {
      spot     <- y_seqIds %in% seq_id
      new.list <- c(new.list, y[spot])
    }
    return(new.list)
  }

  Rcpp::cppFunction('
    #include <unordered_map>
    Rcpp::StringVector
    matchseq_cpp(CharacterVector x,
                 CharacterVector y,
                 bool order_by_x = true) {
      Function getSeqId("getSeqId");
      Function base_intersect("intersect");
      CharacterVector x_seqs = getSeqId(x);
      x_seqs = Rcpp::na_omit(x_seqs);
      CharacterVector y_seqs = getSeqId(y);
      int L = y.size();
      std::unordered_map< std::string, std::string > hashmap;
      for(int i = 0; i < L; i++) {
        hashmap.insert(std::make_pair(y_seqs[i], y[i]));
      }
      CharacterVector ord_seqs(L);
      if (order_by_x) {
        ord_seqs = base_intersect(x_seqs, y_seqs);
      } else {
        ord_seqs = base_intersect(y_seqs, x_seqs);
      }
      int n = ord_seqs.size();
      Rcpp::StringVector res(n);
      for(int j = 0; j < n; j++) {
        res[j] = hashmap[ Rcpp::as< std::string >(ord_seqs[j]) ];
      }
      return res;
      }
  ')

  # Compare
  x    <- getAptamers(sample.adat)[1:1000]
  y    <- rev(getAptamers(sample.adat)[95:1129])

  # Bench Mark
  bnch <- mark(
    matchseq_cpp    = matchseq_cpp(x, y),
    matchSeqIds     = matchSeqIds(x, y),
    matchSeqIds_old = matchSeqIds_old(x, y),
    iterations      = 1000
  )

  # Absolute
  bnch

  # Relative
  summary(bnch, relative = TRUE)
})
