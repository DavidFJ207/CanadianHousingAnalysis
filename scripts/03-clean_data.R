#### Preamble ####
# Purpose: Cleans and merges raw housing market data from various sources, including house prices, GDP, CPI, interest rates, housing construction, and absorption rates, for analysis of the Canadian housing market.
# Author: Gadiel David Flores Jimenez
# Date: 26 November 2024
# Contact: davidgadiel.flores@mail.utoronto.ca
# License: MIT
# Pre-requisites: Ensure all raw data files are correctly formatted and located in the "data/01-raw_data" directory under the respective subfolders ("housing", "rate", "gdp", "cpi", "construction", "absorption"). 
# Ensure the `here` and `tidyverse` packages are installed and loaded in the environment.
# Any other information needed? Dates must match the specified `dates` vector for proper filtering. Ensure all datasets have a column named `REF_DATE` and a column containing the values to be used in the final analysis.


#### Workspace setup ####
library(tidyverse)
library(here)
library(dplyr)
library(arrow)

#### Clean data ####
raw_house_price_data <- read_csv(here::here("data", "01-raw_data", "housing", "housing_price.csv"))
raw_rate_data <- read_csv(here::here("data", "01-raw_data", "rate", "rate.csv"))
raw_gdp_data <- read_csv(here::here("data", "01-raw_data", "gdp", "gdp.csv"))
raw_cpi_data <- read_csv(here::here("data", "01-raw_data", "cpi", "cpi.csv"))
raw_construction_data <- read_csv(here::here("data", "01-raw_data", "construction", "house_construction.csv"))
raw_absorption_data <- read_csv(here::here("data", "01-raw_data", "absorption", "house_absorption.csv"))

dates <- c(
  "1997-07-01", "1997-10-01", "1998-01-01", "1998-04-01", "1998-07-01", "1998-10-01",
  "1999-01-01", "1999-04-01", "1999-07-01", "1999-10-01", "2000-01-01", "2000-04-01",
  "2000-07-01", "2000-10-01", "2001-01-01", "2001-04-01", "2001-07-01", "2001-10-01",
  "2002-01-01", "2002-04-01", "2002-07-01", "2002-10-01", "2003-01-01", "2003-04-01",
  "2003-07-01", "2003-10-01", "2004-01-01", "2004-04-01", "2004-07-01", "2004-10-01",
  "2005-01-01", "2005-04-01", "2005-07-01", "2005-10-01", "2006-01-01", "2006-04-01",
  "2006-07-01", "2006-10-01", "2007-01-01", "2007-04-01", "2007-07-01", "2007-10-01",
  "2008-01-01", "2008-04-01", "2008-07-01", "2008-10-01", "2009-01-01", "2009-04-01",
  "2009-07-01", "2009-10-01", "2010-01-01", "2010-04-01", "2010-07-01", "2010-10-01",
  "2011-01-01", "2011-04-01", "2011-07-01", "2011-10-01", "2012-01-01", "2012-04-01",
  "2012-07-01", "2012-10-01", "2013-01-01", "2013-04-01", "2013-07-01", "2013-10-01",
  "2014-01-01", "2014-04-01", "2014-07-01", "2014-10-01", "2015-01-01", "2015-04-01",
  "2015-07-01", "2015-10-01", "2016-01-01", "2016-04-01"
)
dates <- as.Date(dates)

#### Clean Housing data ####
# Filter data
raw_house_price_data <- raw_house_price_data %>%
  filter(
    GEO == "Canada",
    `New housing price indexes` == "Total (house and land)",
    as.Date(paste0(REF_DATE, "-01")) %in% dates
  )
#### Clean CPI data ####
# Filter data
raw_cpi_data <- raw_cpi_data %>%
  filter(
    GEO == "Canada",
    `Products and product groups` == "All-items",
    as.Date(paste0(REF_DATE, "-01")) %in% dates
  )
#### Clean GDP data ####
# Filter data
raw_gdp_data <- raw_gdp_data %>%
  filter(
    GEO == "Canada",
    `North American Industry Classification System (NAICS)` == "All industries [T001]",
    `Seasonal adjustment` == "Seasonally adjusted at annual rates",
    `Prices` == '2017 constant prices',
    as.Date(paste0(REF_DATE, "-01")) %in% dates
  )
#### Clean Construction data ####
# Filter data
raw_construction_data <- raw_construction_data %>%
  filter(GEO == "Canada",
    `Housing estimates` == "Housing starts",
    `Type of unit` == "Total units",`Seasonal adjustment` == "Unadjusted",
    as.Date(paste0(REF_DATE, "-01")) %in% dates
  )
#### Clean Absorption data ####
# Filter data
raw_absorption_data <- raw_absorption_data %>%
  filter(GEO == "Toronto, Ontario",
         `Completed dwelling units` == "Absorptions",
         `Type of dwelling unit` == "Total units",
         as.Date(paste0(REF_DATE, "-01")) %in% dates
  )
#### Clean Rates data ####
# Filter data
raw_rate_data <- raw_rate_data %>%
  filter(
    GEO == "Canada",
    Rates == "Bank rate",
    as.Date(paste0(REF_DATE, "-01")) %in% dates
  )
#### Merge data ####
merged_df <- raw_house_price_data %>%
  select(REF_DATE, house_price = VALUE) %>%                     # Extract and rename `VALUE` to `house_price`
  full_join(raw_rate_data %>% select(REF_DATE, rate = VALUE), by = "REF_DATE") %>%
  full_join(raw_gdp_data %>% select(REF_DATE, gdp = VALUE), by = "REF_DATE") %>%
  full_join(raw_cpi_data %>% select(REF_DATE, cpi = VALUE), by = "REF_DATE") %>%
  full_join(raw_construction_data %>% select(REF_DATE, construction = VALUE), by = "REF_DATE") %>%
  full_join(raw_absorption_data %>% select(REF_DATE, absorption = VALUE), by = "REF_DATE")


#### Save data ####
write_parquet(merged_df, here::here("data", "02-analysis_data", "analysis_data.parquet"))