#### Preamble ####
# Purpose: Tests the structure and validity of the analysis dataset for the Canadian housing analysis project.
# Author: Gadiel David Flores Jimenez
# Date: 26 November 2024
# Contact: davidgadiel.flores@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Ensure the required libraries (tidyverse, testthat, arrow, here) are installed and loaded.
#   - The Parquet file `analysis_data.parquet` must be present in the specified path (`data/02-analysis_data/`).
#   - Columns in the dataset must match the expected structure: REF_DATE, house_price, rate, gdp, cpi, construction, absorption.
# Any other information needed: 
#   - The dataset should have no missing values, all numeric columns should contain non-negative values, and the 'rate' column must have at least two unique values.

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)
library(here)

# Load the data from the Parquet file
file_path <- here("data", "02-analysis_data", "analysis_data.parquet")

if (!file.exists(file_path)) {
  stop("The specified file does not exist: ", file_path)
}

# Assign to a more descriptive variable name to avoid conflicts
analysis_data <- read_parquet(file_path)

#### Test data ####
test_that("data loads correctly", {
  expect_s3_class(analysis_data, "data.frame")
  expect_true(nrow(analysis_data) > 0) # Ensure there are rows in the dataset
})

# Test that the dataset has 7 columns
test_that("dataset has 7 columns", {
  expect_equal(ncol(analysis_data), 7)
})

# Test that specified columns are numeric
numeric_columns <- c("house_price", "rate", "gdp", "cpi", "construction", "absorption")
test_that("all specified columns are numeric", {
  expect_true(all(sapply(analysis_data[numeric_columns], is.numeric)))
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# Test that the numeric columns contain only non-negative values
test_that("numeric columns contain non-negative values", {
  expect_true(all(sapply(analysis_data[numeric_columns], function(x) all(x >= 0, na.rm = TRUE))))
})

# Test that the 'rate' column contains at least 2 unique values
test_that("'rate' column contains at least 2 unique values", {
  expect_true(length(unique(analysis_data$rate)) >= 2)
})

# Test that 'house_price' has no empty or invalid entries
test_that("'house_price' column has valid values", {
  expect_true(all(!is.na(analysis_data$house_price) & analysis_data$house_price != ""))
})
