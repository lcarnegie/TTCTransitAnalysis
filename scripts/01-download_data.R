#### Preamble ####
# Purpose: Downloads and saves the data from OpenDataToronto
# Author: Luca Carnegie
# Date: 23 Jan 2023
# Contact: luca.carnegie@mail.utoronto.ca


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)


#### Download data ####

# get all the bus data
bus_data <- list_package_resources("e271cdae-8788-4980-96ce-6a5c95bc6618") |>
  filter(name == "ttc-bus-delay-data-2023") |>
  get_resource()

#subway data 
subway_data <- list_package_resources("996cfe8d-fb35-40ce-b569-698d51fc683b") |>
  filter(name == "ttc-subway-delay-data-2023") |>
  get_resource()
  
#get Streetcar Data
streetcar_data <-list_package_resources("b68cb71b-44a7-4394-97e2-5d2f41462a5d") |>
  filter(name == "ttc-streetcar-delay-data-2023") |>
  get_resource()


#### Save data ####
write_csv(bus_data, "inputs/data/bus_data.csv") 
write_csv(subway_data, "inputs/data/subway_data.csv") 
write_csv(streetcar_data, "inputs/data/streetcar_data.csv") 

         
