# Loading packages

library(dplyr)
library(worldfootballR)

# Getting data and data manipulation

shots <- understat_league_season_shots(league = "EPL", season_start_year = 2020)
data <- shots %>%
  filter(situation == "OpenPlay") %>%
  mutate(NewX = X * 120,
         NewY = Y * 80)

# Setting point and calculating variance

data <- data %>%
  mutate(Xc = 120,
         Yc = 40,
         Xsd = Xc - NewX,
         Ysd = Yc - NewY)

data1 <- data[, c(8,26,27)]

data1 <- data1 %>%
  mutate(xcol = Xsd * Xsd,
         ycol = Ysd * Ysd)

data1 <- data1[, c(1,4,5)]
data1 <- aggregate(.~player,data=data1,FUN=sum)

# Grouping players to get number of shots

data2 <- data %>%
  group_by(player) %>%
  summarise(n())

data <- cbind(data1, data2)
data <- data[, c(1,2,3,5)]

# Calculating standard deviation

data <- data %>%
  mutate(xsum = xcol / `n()`,
         ysum = ycol / `n()`, 
         xval = sqrt(xsum), 
         yval = sqrt(ysum))

data <- data[, c(1,4,7,8)]