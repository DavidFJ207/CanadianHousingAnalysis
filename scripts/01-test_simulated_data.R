#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
  #electoral divisions dataset.
# Author: Gadiel David Flores Jimenez
# Date: 26 November 2024
# Contact: davidgadiel.flores@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(arrow)
analysis_data <- read_parquet("data/00-simulated_data/simulated_data.parquet")


# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 151 rows
if (nrow(analysis_data) == 1000) {
  message("Test Passed: The dataset has 151 rows.")
} else {
  stop("Test Failed: The dataset does not have 151 rows.")
}

# Check if the dataset has 6 columns
if (ncol(analysis_data) == 6) {
  message("Test Passed: The dataset has 6 columns.")
} else {
  stop("Test Failed: The dataset does not have 6 columns.")
}

# Check if all values in the 'house_price' column are unique
if (n_distinct(analysis_data$house_price) == nrow(analysis_data)) {
  message("Test Passed: All values in 'house_price' are unique.")
} else {
  stop("Test Failed: The 'house_price' column contains duplicate values.")
}

# Check if the 'construction' column contains only valid numeric values
if (all(is.numeric(analysis_data$construction))) {
  message("Test Passed: The 'construction' column contains only numeric values.")
} else {
  stop("Test Failed: The 'construction' column contains invalid values.")
}

# Check if the 'absorption' column contains only positive values
if (all(analysis_data$absorption > 0)) {
  message("Test Passed: The 'absorption' column contains only positive values.")
} else {
  stop("Test Failed: The 'absorption' column contains non-positive values.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'house_price', 'construction', and 'gdp' columns
if (all(analysis_data$house_price != "" & analysis_data$construction != "" & analysis_data$gdp != "")) {
  message("Test Passed: There are no empty strings in 'house_price', 'construction', or 'gdp'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if the 'rate' column contains at least two unique values
if (n_distinct(analysis_data$rate) >= 2) {
  message("Test Passed: The 'rate' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'rate' column contains less than two unique values.")
}

# Check if the 'cpi' column contains only valid numeric values
if (all(is.numeric(analysis_data$cpi))) {
  message("Test Passed: The 'cpi' column contains only numeric values.")
} else {
  stop("Test Failed: The 'cpi' column contains invalid values.")
}
