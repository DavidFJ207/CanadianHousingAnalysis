#### Preamble ####
# Purpose: Develop and validate a multiple linear regression model to predict house prices based on economic and housing indicators.
# Author: Gadiel David Flores Jimenez
# Date: 2024/11/25
# Contact: davidgadiel.flores@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   - The dataset `analysis_data.csv` must be available in the `data/02-analysis_data/` directory.
#   - Required libraries (`tidyverse`, `caret`, `car`) must be installed.
#   - The `here` package should be configured correctly to reference project files.
# Any other information needed:
#   - This script performs exploratory data analysis, model fitting, assumption diagnostics, and validation.
#   - Outputs include diagnostic plots, validation metrics, and a saved final model object (`final_model.rds`).



#### Workspace setup ####
library(tidyverse)
library(caret)
library(car)

### **Step 1: Data Preparation and Exploration** ###
# Read and prepare the data
analysis_data <- read_csv(here::here("data", "02-analysis_data", "analysis_data.csv"))

# Split data into training (80%) and testing (20%) datasets
set.seed(123)
train_index <- createDataPartition(analysis_data$house_price, p = 0.8, list = FALSE)
train_data <- analysis_data[train_index, ]
test_data <- analysis_data[-train_index, ]

# Explore correlations among predictors
correlation_matrix <- cor(train_data[, c("rate", "gdp", "cpi", "construction", "absorption")], use = "complete.obs")
cat("Correlation Matrix:\n")
print(correlation_matrix)

# Initial check for multicollinearity using VIF
initial_model <- lm(house_price ~ rate + gdp + cpi + construction + absorption, data = train_data)
initial_vif <- vif(initial_model)
cat("Initial VIF Values:\n")
print(initial_vif)

# Remove highly correlated predictors (e.g., `cpi`)
model_without_cpi <- lm(house_price ~ rate + gdp + construction + absorption, data = train_data)
vif_without_cpi <- vif(model_without_cpi)
cat("VIF Values after removing cpi:\n")
print(vif_without_cpi)

### **Step 2: Model Fitting and Diagnostics** ###
# Fit the updated model and check assumptions
cat("Summary of the model without cpi:\n")
print(summary(model_without_cpi))

# Residual diagnostics
residuals <- residuals(model_without_cpi)
fitted_values <- fitted(model_without_cpi)

# Linearity: Residuals vs. Fitted Plot
plot(fitted_values, residuals,
     main = "Residuals vs. Fitted Values",
     xlab = "Fitted Values",
     ylab = "Residuals",
     pch = 20,
     col = "blue")
abline(h = 0, col = "red", lty = 2)

# Homoscedasticity: Scale-Location Plot
sqrt_abs_residuals <- sqrt(abs(residuals))
plot(fitted_values, sqrt_abs_residuals,
     main = "Scale-Location Plot",
     xlab = "Fitted Values",
     ylab = "Square Root of Absolute Residuals",
     pch = 20,
     col = "blue")
abline(h = mean(sqrt_abs_residuals), col = "red", lty = 2)

# Normality: Q-Q Plot
qqnorm(residuals, main = "Normal Q-Q Plot")
qqline(residuals, col = "red", lty = 2)

# Summarize residual diagnostics
cat("Summary of residuals:\n")
print(summary(residuals))
cat("\nStandard deviation of residuals:\n")
print(sd(residuals))

### **Step 3: Model Refinement and Validation** ###
# Simplify model by evaluating predictors' significance
final_model <- step(model_without_cpi, direction = "both", trace = FALSE)  # Stepwise AIC-based refinement
cat("Final Model Summary:\n")
print(summary(final_model))

# Validate model on test data
predictions <- predict(final_model, newdata = test_data)
test_residuals <- test_data$house_price - predictions

# Compute validation metrics
rmse <- sqrt(mean(test_residuals^2))
mae <- mean(abs(test_residuals))
r_squared <- 1 - (sum(test_residuals^2) / sum((test_data$house_price - mean(test_data$house_price))^2))

cat("Validation Metrics:\n")
cat("RMSE:", round(rmse, 2), "\n")
cat("MAE:", round(mae, 2), "\n")
cat("R-squared:", round(r_squared, 4), "\n")

#### Save final model ####
saveRDS(
  final_model,
  file = "models/final_model.rds"
)


