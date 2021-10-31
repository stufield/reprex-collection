
reprex::reprex({
  # wish to map values of 'x'
  a <- data.frame(x = rep(letters[1:3], each = 3))
  a

  # create the lookup-table/hash map
  map <- data.frame(x = letters[1:4], newx = c("dog", "cat", "bird", "turtle"))
  map

  # use table join
  dplyr::left_join(a, map)
})
