#### Preamble ####
# Purpose: EDA and fits a linear regression model to analyze the relationships between `house_price` 
# and its predictors (`rate`, `gdp`, `cpi`, `construction`, and `absorption`). 
# The model is saved for further analysis and validation.
# Author: Gadiel David Flores Jimenez
# Date: 2024/11/25
# Contact: davidgadie.flores@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Ensure the dataset `analysis_data.csv` is available in the folder 
#   `data/02-analysis_data/`.
# - Required R libraries (`tidyverse`, `corrplot`, `car`) should be installed.
# Any other information needed?
# - This script assumes that the dataset is clean and formatted appropriately 
#   with the following columns:
#   - `house_price`: Response variable.
#   - `rate`, `gdp`, `cpi`, `construction`, `absorption`: Predictor variables.



#### Workspace setup ####
library(tidyverse)
library(corrplot)
library(car)

#### Read data ####
analysis_data <- read_csv(here::here("data", "02-analysis_data", "analysis_data.csv"))

### Model data ####
response <- "house_price"
predictors <- c("rate", "gdp", "cpi", "construction", "absorption")

# relevant columns
eda_data <- analysis_data %>% 
  select(all_of(c(response, predictors)))

# Create scatterplots with regression lines
for (predictor in predictors) {
  # Create the plot and assign it to a variable
  p <- ggplot(eda_data, aes_string(x = predictor, y = response)) +
    geom_point(alpha = 0.7) +
    geom_smooth(method = "lm", color = "blue", se = FALSE) +
    labs(title = paste("Scatterplot of", response, "vs", predictor),
         x = predictor, y = response) +
    theme_minimal()
  
  print(p)
}

# Correlation matrix
cor_matrix <- cor(eda_data, use = "complete.obs")
corrplot(cor_matrix, method = "circle", type = "upper", tl.col = "black", tl.srt = 45)

# linear regression model
linear_model <- lm(house_price ~ rate + gdp + cpi + construction + absorption, data = eda_data)


#### Save model ####
saveRDS(
  linear_model,
  file = "models/first_model.rds"
)


