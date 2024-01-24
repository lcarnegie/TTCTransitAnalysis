#### Preamble ####
# Purpose: Simulates cleaned TTC bus, subway, and streetcar data
# Author: Luca Carnegie
# Date: 23 January 2024

#Import relevant libraries
install.packages("tidyverse")
install.packages('janitor')
install.packages("lubridate")
library(tidyverse)
library(ggplot2)
library(janitor)
library(lubridate)
library(wakefield)

#### Data expectations ####
# Columns: year, month, day, weekday, hour, minute, line, vehicle, incident, delay
# 
# The year, month, and day variables contain values within their specified ranges.
# The weekday variable only include the days of the week from Monday to Sunday.
# The hour and minute variable only contain values within their specified ranges. 
# The line variable only includes three categories: "97", "507", "1" 
# The vehicle variables only includes  three categories: "Bus", "Subway", "Streetcar" 
# The incident variable only includes four categories: "Mechanical", "Operations", "General Delay", "Emergency"
# The delay variable contains the values within it's specified range. 


set.seed(27)

num_obs <- 500

simulated_data <- 
  tibble(
    year = 2023,
    month = sample(1:12, num_obs, replace = TRUE),
    day = sample(1:31, num_obs, replace = TRUE),
    weekday = sample(c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                       "Friday", "Saturday"), num_obs, replace = TRUE),
    hour = sample(0:23, num_obs, replace = TRUE),
    minute = sample(0:59, num_obs, replace = TRUE),
    line = sample(c("1", "2", "3"), num_obs, replace = TRUE),
    vehicle = sample(c("Subway", "Bus", "Streetcar"), num_obs, replace = TRUE),
    incident = sample(c("Mechanical", "Operations", "General Delay", "Emergency"), num_obs, replace = TRUE),
    delay = sample(0:47, num_obs, replace = TRUE),
  )

#Bar chart of Reasons for delay vs. # of incidents 
simulated_data |>
  ggplot(mapping = aes(x = incident)) +
  geom_bar() + 
  theme_minimal()

#Line chart of how avg. delay time changes over the months

#Calculate avg. delays 
avg_delay <- simulated_data |> group_by(month, vehicle) |> summarise(delay = mean(delay, na.rm = TRUE), .groups = "drop")


#convert month to factor (categorical data)
avg_delay$month <- factor(avg_delay$month, levels = 1:12, labels = month.abb[1:12])

#plot the graph
avg_delay |>
  ggplot(aes(x=month, y=delay, color=vehicle, group=vehicle)) + 
  geom_line() +
  labs(title="Monthly Change in Delays by Vehicle", x="Month", y="Monthly Avg. Delay") + 
  scale_color_manual(values=c("blue","green", "red"), labels=c("Bus","Streetcar", "Subway")) +
  theme_minimal()


  




