# Loading necessary packages

library(understatr)
library(ggsoccer)
library(dplyr)
library(ggplot2)

# Getting the data + manipulating

data <- get_player_shots(5555)

data <- data %>%
  filter(situation == "OpenPlay",
         year == "2020") %>%
  mutate(NewX = X * 120,
         NewY = Y * 80,
         Xm = mean(NewX),
         Ym = mean(NewY))

# Plotting pitch

p <- ggplot()+
  annotate_pitch(dimensions = pitch_statsbomb, fill = "#000000", colour = "white")+
  theme_pitch()+
  coord_flip(xlim = c(60, 120),
             ylim = c(82, -2)) +
  theme(plot.background = element_rect(colour = "#000000", fill = "#000000"),
        panel.background = element_rect(colour = "#000000", fill = "#000000"))
p

# Final map

p + geom_segment(data = data, aes(x = 60, xend = 120, y = 40, yend = 40), colour = "white", size = 1) +
  geom_segment(data = data, aes(x = 120, xend = 106.5556, y = 40, yend = 41.24194), colour = "white", size = 1, linetype = "dotted") +
  geom_point(data = data, aes(x = Xm, y = Ym), colour = "Red", size = 4)