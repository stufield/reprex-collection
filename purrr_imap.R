#' Getting acquainted with `purrr::imap`
#' ---------------------
#'   * If you're not using `imap`, you're doing it wrong.
#'   * A variant of `purrr::map2` ... alias for `purrr::map2(x, names(x), ...)`
# ------------------
library(tibble)
library(ggplot2)
library(purrr)
data <- tibble(`Group A` = rnorm(100),   # tibbles can have spaces in names!
               `Group B` = rnorm(100)
)

data %>%
  purrr::imap( ~ {
    # .x is the component
    # .y is *name* of the component
    data.frame(x = .x) %>%
      ggplot(aes(x = x)) +
      stat_ecdf() +
      labs(y = "P( x < X )") +
      ggtitle(
        stringr::str_glue(
          "eCDF of {.y}"
        )
      ) +
      NULL
  })

# Also has all the `_X` ancillary functions:
data %>%
  purrr::imap_chr( ~ {
    paste0(.y, " = ", format(mean(.x), digits = 4))
  })

# Also has a `side-effect` version: `purrr::iwalk`:
data %>%
  purrr::iwalk( ~ {
    message(
      stringr::str_glue(
      "This is the mean of vector {.y}: {round(mean(.x), 4)}"
      )
    )
  })
