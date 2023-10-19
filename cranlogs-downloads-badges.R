# source:
#   https://cranlogs.r-pkg.org
#   https://github.com/r-hub/cranlogs.app

httr::GET(url = "https://cranlogs.r-pkg.org/downloads/total/last-year/gitr") |>
  httr::content("parsed", encoding = "UTF-8") |> unlist()

httr::GET(url = "https://cranlogs.r-pkg.org/downloads/total/2023-03-15/SomaDataIO") |>
  httr::content("parsed", encoding = "UTF-8") |> unlist()

httr::GET(url = "https://cranlogs.r-pkg.org/downloads/total/2023-03-15:2023-07-01/SomaDataIO") |>
  httr::content("parsed", encoding = "UTF-8") |> unlist()

httr::GET(url = "https://cranlogs.r-pkg.org/downloads/total/last-month/SomaDataIO") |>
  httr::content("parsed", encoding = "UTF-8") |> unlist()

httr::GET(url = "https://cranlogs.r-pkg.org/downloads/total/last-day/SomaDataIO") |>
  httr::content("parsed", encoding = "UTF-8") |> unlist()



# badges
httr::GET(url = "https://cranlogs.r-pkg.org/badges/grand-total/SomaDataIO")

