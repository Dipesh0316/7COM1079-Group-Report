
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


# 4. Visualisation


# 4.1 Scatter plot with regression line
p_scatter <- ggplot(data_clean,
                    aes(x = AlcoholConsumption,
                        y = HappinessScore)) +
  geom_point(color = "blue", size = 2) +
  geom_smooth(method = "lm",
              color = "red",
              se = TRUE) +
  labs(
    title = "Alcohol Consumption vs Happiness Score",
    x = "Total Alcohol Consumption (litres per capita)",
    y = "Happiness Score"
  ) +
  theme_minimal()

print(p_scatter)

# 4.2 Histogram of Alcohol Consumption
p_hist <- ggplot(data_clean,
                 aes(x = AlcoholConsumption)) +
  geom_histogram(bins = 20,
                 fill = "skyblue",
                 color = "white") +
  labs(
    title = "Distribution of Total Alcohol Consumption",
    x = "Total Alcohol Consumption (litres per capita)",
    y = "Number of Countries"
  ) +
  theme_minimal()

print(p_hist)


# 5. Statistical analysis

# Pearson correlation test
cor_test <- cor.test(
  data_clean$AlcoholConsumption,
  data_clean$HappinessScore,
  method = "pearson"
)

print(cor_test)


# 6. Additional grouping (optional analysis)

# Create high vs low consumption groups
data_clean$Group <- ifelse(
  data_clean$AlcoholConsumption >
    mean(data_clean$AlcoholConsumption),
  "High Consumption",
  "Low Consumption"
)

# Box plot comparing happiness scores by group
p_box <- ggplot(data_clean,
                aes(x = Group,
                    y = HappinessScore,
                    fill = Group)) +
  geom_boxplot() +
  labs(
    title = "Happiness Score by Alcohol Consumption Group",
    x = "Alcohol Consumption Group",
    y = "Happiness Score"
  ) +
  theme_minimal()

print(p_box)


# 7. Save plots (for report/GitHub)

ggsave("scatter_plot.png", p_scatter, width = 7, height = 5)
ggsave("histogram.png", p_hist, width = 7, height = 5)
ggsave("box_plot.png", p_box, width = 7, height = 5)


# End of Script

