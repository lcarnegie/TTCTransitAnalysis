#### Preamble ####
# Prerequisites: 01-download_data.R
# Purpose: Cleans the raw TTC data downloaded from OpenDataToronto
# Author: Luca Carnegie 
# Date: January 24, 2024
# Contact: luca.carnegie@mail.utoronto.ca



#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)


#### Clean data ####

raw_data_bus <- read_csv("inputs/data/bus_data.csv")
raw_data_streetcar <- read_csv("inputs/data/streetcar_data.csv")
raw_data_subway <- read_csv("inputs/data/subway_data.csv")

#Add vehicle column 
raw_data_subway$vehicle <- "Subway"
raw_data_streetcar$vehicle <- "Streetcar"
raw_data_bus$vehicle <- "Bus"

# from https://www.listendata.com/2015/06/r-keep-drop-columns-from-data-frame.html 

## Subway 
raw_data_subway <- raw_data_subway |> select(-Code, -Bound, -Vehicle, -`Min Gap`)
raw_data_subway$vehicle <- "Subway"
raw_data_subway$incident <- "NA"
raw_data_subway <- rename(raw_data_subway, Location = Station)
raw_data_subway <- raw_data_subway |> mutate(
  Line =
    case_match(
      Line,
      "YU" ~ "1",
      "BD" ~ "2", 
      "SRT" ~ "3", 
      "SHP" ~ "4",
      "YU / BD" ~ "1",
      "BD/YU" ~ "2", 
      "BLOOR DANFORTH & YONGE" ~ "2",
      "YUS/BD" ~ "1",
      "BD LINE 2" ~ "2", 
      "999" ~ "NA",
      "YUS" ~ "1",
      "YU & BD" ~ "1",
      "77 SWANSEA" ~ "NA"
    )
)

raw_data_subway <- raw_data_subway |> select(Date, Time, Day, vehicle, Line, Location, incident, `Min Delay`)
raw_data_subway <- rename(raw_data_subway, Incident = incident)
raw_data_subway <- raw_data_subway |> mutate(Line = as.character(Line))


## Streetcar
raw_data_streetcar <- raw_data_streetcar |> select(-Bound, -Vehicle, -`Min Gap`)
raw_data_streetcar <- raw_data_streetcar |> select(Date, Time, Day, vehicle, Line, Location, Incident, `Min Delay`)
raw_data_streetcar <- raw_data_streetcar |> mutate(Line = as.character(Line))
raw_data_streetcar

## Bus
raw_data_bus
raw_data_bus <- raw_data_bus |> select(-Direction, -Vehicle, -`Min Gap`)
raw_data_bus <- rename(raw_data_bus, Line = Route)
raw_data_bus <- raw_data_bus |> select(Date, Time, Day, vehicle, Line, Location, Incident, `Min Delay`)
raw_data_bus <- raw_data_bus |> mutate(Line = as.character(Line))
raw_data_bus


#Combine the three datasets 
combined_data <- bind_rows(raw_data_bus, raw_data_streetcar, raw_data_subway)

#Fix some categories
combined_data <- combined_data |> mutate(
  Incident =
    case_match(
      Incident,
      "Diversion"  ~ "Diversion", 
      "Security"  ~ "Security", 
      "Cleaning - Unsanitary" ~ "Cleaning",
      "Emergency Services"  ~ "Emergency Services", 
      "Collision - TTC" ~ "Collision",
      "Mechanical" ~ "Mechanical",
      "Operations - Operator" ~ "Operations",
      "Investigation" ~ "Investigation", 
      "Utilized Off Route" ~ "Diversion",
      "General Delay" ~ "General Delay", 
      "Road Blocked - NON-TTC Collision" ~ "Collision",
      "Held By" ~ "Held By" , 
      "Vision" ~ "Vision", 
      "Operations" ~ "Operations", 
      "Collision - TTC Involved" ~ "Collision",
      "Late Entering Service" ~ "Late Entering Service", 
      "Overhead" ~ "Overhead", 
      "Rail/Switches" ~ "Rail/Switches", 
      "NA" ~ "N/A"
    )
)

combined_data
  

#### Save data ####
write_csv(combined_data, "outputs/data/cleaned_dataset.csv")
