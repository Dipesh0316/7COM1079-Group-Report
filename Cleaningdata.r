
# Analysis.R
# Module: 7COM1079
# Topic: Alcohol Consumption and Happiness
# Purpose: Data cleaning, visualisation, and hypothesis testing



# 1. Load required libraries

library(readr)
library(ggplot2)
library(tidyverse)


# 2. Load the dataset

data <- read_csv("HappinessAlcoholConsumption.csv")

# Preview the data
head(data)
str(data)
summary(data)


# 3. Data preparation & cleaning

# Create a new variable for total alcohol consumption
data$AlcoholConsumption <- data$Beer_PerCapita +
  data$Spirit_PerCapita +
  data$Wine_PerCapita

# Keep only required columns and remove missing values
data_clean <- na.omit(
  data[, c("AlcoholConsumption", "HappinessScore")]
)

