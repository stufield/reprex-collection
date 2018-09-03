library(ggplot2)
library(SomaPlot)

# default ggplot2 theme
mtcars %>%
  ggplot(aes(mpg, hp, colour = cyl)) +
  geom_point() +
  ggtitle("Figure Title (mtcars)") +
  geom_smooth(method = "loess")

# new theme_soma()
mtcars %>%
  ggplot(aes(mpg, hp, colour = cyl)) +
  geom_point() +
  ggtitle("Figure Title (mtcars)") +
  geom_smooth(method = "loess") +
  theme_soma()

# theme_soma() allows some arguments
# 1) put legend back to default ggplot2 position
# 2) make font sizes larger: 11 -> 15
# 3) put title position back to default ggplot2
mtcars %>%
  ggplot(aes(mpg, hp, colour = cyl)) +
  geom_point() +
  ggtitle("Figure Title (mtcars)") +
  geom_smooth(method = "loess") +
  theme_soma(legend.position = "right",
             base_size = 15, hjust = 0)
