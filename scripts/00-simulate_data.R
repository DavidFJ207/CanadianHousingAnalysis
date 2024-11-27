#### Preamble ####
# Purpose: Simulates a dataset of housing market predictors and their impact on
  # the New Housing Price Index (NHPI). 
# Author: Gadiel David Flores Jimenez
# Date: 26-11-2024
# Contact: davidgadiel.flores@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj
 # and the directory "data/00-simulated_data" exists to save the output file.

#### Workspace setup ####
library(tidyverse)
library(arrow)
set.seed(853)

#### Simulate data ####
n <- 1000 

# Simulate predictor variables
construction <- rnorm(n, mean = 200, sd = 50)
absorption <- rnorm(n, mean = 180, sd = 40)       
gdp <- rnorm(n, mean = 2.5, sd = 0.5)             
cpi <- rnorm(n, mean = 120, sd = 10)                
rate <- rnorm(n, mean = 3, sd = 0.75)

# Generate NHPI as a function of predictors + random noise
house_price <- 100 + 
  0.3 * constructed_homes + 
  0.4 * absorption + 
  1.5 * gdp - 
  0.8 * rate +
  rnorm(n, mean = 0, sd = 10)  # Adding some random noise

# Combine into a dataframe
analysis_data <- tibble(
  house_price,
  construction,
  absorption,
  gdp,
  cpi,
  rate
)

#### Save data ####
write_parquet(analysis_data, "data/00-simulated_data/simulated_data.parquet")


