#### Preamble ####
# Purpose: Simulates TTC bus, subway, and streetcar 
# data to be gathered from OpenDataToronto 
# Author: Luca Carnegie
# Date: 23 January 2024

#Import relevant libraries
install.packages("tidyverse")
install.packages('janitor')
install.packages("lubridate")
install.packages("wakefield")
library(tidyverse)
library(janitor)
library(lubridate)
library(wakefield)

# Simulate the dataset with 150 observations

set.seed(27)

simulated_data <- 
  tibble(
    "Transport Genre" = sample(
      x = c("Bus", "Streetcar", "Subway"),
      size = 150,
      replace = TRUE
    ), 
    "Date" = date_stamp(
      150,
      random = FALSE,
      x = NULL,
      start = "2023-01-01",
      k = 12,
      by = "-1 months",
      prob = NULL,
      name = "Date"
    ),
    "Time" = time_stamp(
      150,
      x = seq(0, 23, by = 1),
      prob = NULL,
      random = FALSE,
      name = "Time"
    ),
    "Location" = sample(
      x = c("Bloor-Yonge Station", "Bay St. and King St.", "York Mills Station", "Queen and Church"),
      size = 150,
      replace = TRUE
    ),
    "Reason of Delay" = sample(
      x = c("Mechanical", "Operations", "General Delay", "Emergency"),
      size = 150,
      replace = TRUE
    ),
    "Delay Time (mins)" = sample(1:47, 150, replace=TRUE)
    
  )

# 
