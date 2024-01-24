#### Preamble ####
# Purpose: Tests Cleaned Dataset Developed
# Author: Luca Carnegie
# Date: 24 January 2023
# Contact: luca.carnegie@mail.utoronto.ca
# Pre-requisites: 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)

#### Test data ####

dataset <- read_csv("outputs/data/cleaned_dataset.csv")

# Load necessary libraries
library(dplyr)
library(testthat)

# Assume df is your data frame

# Test that the data frame has the correct columns
test_that("Data frame has correct columns", {
  expected_cols <- c("year", "month", "day", "weekday", "hour", "minute", "line", "vehicle", "incident", "delay")
  expect_equal(colnames(df), expected_cols)
})

# Test that there are no missing values
test_that("No missing values", {
  expect_equal(sum(is.na(df)), 0)
})

# Test that numeric columns have reasonable values
test_that("Numeric columns have reasonable values", {
  expect_true(all(df$year >= 2000 & df$year <= 2025))
  expect_true(all(df$month >= 1 & df$month <= 12))
  expect_true(all(df$day >= 1 & df$day <= 31))
  expect_true(all(df$hour >= 0 & df$hour <= 23))
  expect_true(all(df$minute >= 0 & df$minute <= 59))
  expect_true(all(df$delay >= 0))
})

# Test that categorical columns have expected levels
test_that("Categorical columns have expected levels", {
  expect_true(all(df$weekday %in% c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))
  expect_true(all(df$vehicle %in% c("Subway", "Bus", "Streetcar")))
  expect_true(all(df$incident %in% c("Mechanical", "Operations", "General Delay", "Emergency")))
})
