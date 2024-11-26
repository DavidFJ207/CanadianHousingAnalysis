#### Preamble ####
# Purpose: Downloads and saves housing-related data from Statistics Canada, including housing prices, CPI, GDP, construction, absorption, and rate data.
# Author: Gadiel David Flores Jimenez
# Date: 2024/11/25
# Contact: davidgadiel.flores@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `here` package must be installed and loaded.
# - The `httr` package must be installed and loaded.
# - Ensure that the folder structure for saving the data is writable by the user.
# Any other information needed:
# - Data is sourced from Statistics Canada tables using direct download links to their CSV files.
# - The data is organized into separate folders based on its type
# - The zip files are deleted after extraction to save space.
# - The extracted CSV files are renamed to make them easier to identify and use in subsequent analyses.

#### Workspace setup ####
library(tidyverse)
library(rsdmx)
library(httr)
library(utils)
library(here)

#### Download Housing data ####
url <- "https://www150.statcan.gc.ca/n1/tbl/csv/18100052-eng.zip"

# File path using
dir.create(here("data", "01-raw_data"), recursive = TRUE, showWarnings = FALSE)
destfile <- here("data", "01-raw_data","housing", "statcan_data.zip")

# Download the zip file
GET(url, write_disk(destfile, overwrite = TRUE))

# Unzip the downloaded file
unzip(destfile, exdir = here("data", "01-raw_data","housing"))

# List the files
unzipped_files <- list.files(here("data", "01-raw_data","housing"), full.names = TRUE)

# Delete the zip file after extraction
file.remove(destfile)

# Identify the first CSV file and rename it
data_file <- unzipped_files[grepl("\\.csv$", unzipped_files)][1]
new_csv_path <- here("data", "01-raw_data","housing", "housing_price.csv")
file.rename(data_file, new_csv_path)

#### Download CPI data ####
url <- "https://www150.statcan.gc.ca/n1/tbl/csv/18100004-eng.zip"

# File path using
dir.create(here("data", "01-raw_data"), recursive = TRUE, showWarnings = FALSE)
destfile <- here("data", "01-raw_data","cpi", "statcan_data.zip")

# Download the zip file
GET(url, write_disk(destfile, overwrite = TRUE))

# Unzip the downloaded file
unzip(destfile, exdir = here("data", "01-raw_data","cpi"))

# List the files
unzipped_files <- list.files(here("data", "01-raw_data","cpi"), full.names = TRUE)

# Delete the zip file after extraction
file.remove(destfile)

# Identify the first CSV file and rename it
data_file <- unzipped_files[grepl("\\.csv$", unzipped_files)][1]
new_csv_path <- here("data", "01-raw_data","cpi", "cpi.csv")
file.rename(data_file, new_csv_path)

#### Download GDP data ####
url <- "https://www150.statcan.gc.ca/n1/tbl/csv/36100434-eng.zip"

# File path using
dir.create(here("data", "01-raw_data"), recursive = TRUE, showWarnings = FALSE)
destfile <- here("data", "01-raw_data","gdp", "statcan_data.zip")

# Download the zip file
GET(url, write_disk(destfile, overwrite = TRUE))

# Unzip the downloaded file
unzip(destfile, exdir = here("data", "01-raw_data","gdp"))

# List the files
unzipped_files <- list.files(here("data", "01-raw_data","gdp"), full.names = TRUE)

# Delete the zip file after extraction
file.remove(destfile)

# Identify the first CSV file and rename it
data_file <- unzipped_files[grepl("\\.csv$", unzipped_files)][1]
new_csv_path <- here("data", "01-raw_data","gdp", "gdp.csv")
file.rename(data_file, new_csv_path)
#### Download Construction data ####
url <- "https://www150.statcan.gc.ca/n1/tbl/csv/34100135-eng.zip"

# File path using
dir.create(here("data", "01-raw_data", "construction"), recursive = TRUE, showWarnings = FALSE)
destfile <- here("data", "01-raw_data","construction", "statcan_data.zip")

# Download the zip file
GET(url, write_disk(destfile, overwrite = TRUE))

# Unzip the downloaded file
unzip(destfile, exdir = here("data", "01-raw_data","construction"))

# List the files
unzipped_files <- list.files(here("data", "01-raw_data","construction"), full.names = TRUE)

# Delete the zip file after extraction
file.remove(destfile)

# Identify the first CSV file and rename it
data_file <- unzipped_files[grepl("\\.csv$", unzipped_files)][1]
new_csv_path <- here("data", "01-raw_data","construction", "house_construction.csv")
file.rename(data_file, new_csv_path)

#### Download Absorption data ####
url <- "https://www150.statcan.gc.ca/n1/tbl/csv/34100149-eng.zip"

# File path using
dir.create(here("data", "01-raw_data", "absorption"), recursive = TRUE, showWarnings = FALSE)
destfile <- here("data", "01-raw_data","absorption", "statcan_data.zip")

# Download the zip file
GET(url, write_disk(destfile, overwrite = TRUE))

# Unzip the downloaded file
unzip(destfile, exdir = here("data", "01-raw_data","absorption"))

# List the files
unzipped_files <- list.files(here("data", "01-raw_data","absorption"), full.names = TRUE)

# Delete the zip file after extraction
file.remove(destfile)

# Identify the first CSV file and rename it
data_file <- unzipped_files[grepl("\\.csv$", unzipped_files)][1]
new_csv_path <- here("data", "01-raw_data","absorption", "house_absorption.csv")
file.rename(data_file, new_csv_path)

#### Download Rates data ####
url <- "https://www150.statcan.gc.ca/n1/tbl/csv/10100122-eng.zip"

# File path using
dir.create(here("data", "01-raw_data", "rate"), recursive = TRUE, showWarnings = FALSE)
destfile <- here("data", "01-raw_data","rate", "statcan_data.zip")

# Download the zip file
GET(url, write_disk(destfile, overwrite = TRUE))

# Unzip the downloaded file
unzip(destfile, exdir = here("data", "01-raw_data","rate"))

# List the files
unzipped_files <- list.files(here("data", "01-raw_data","rate"), full.names = TRUE)

# Delete the zip file after extraction
file.remove(destfile)

# Identify the first CSV file and rename it
data_file <- unzipped_files[grepl("\\.csv$", unzipped_files)][1]
new_csv_path <- here("data", "01-raw_data","rate", "rate.csv")
file.rename(data_file, new_csv_path)



         
