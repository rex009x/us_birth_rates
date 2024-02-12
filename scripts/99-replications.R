#### Preamble ####
# Purpose: Replicated graphs from... [...UPDATE THIS...]
# Author: Aaron Xiaozhou Liu, Jimmy Luc, Maroosh Gillani
# Date: 9 February 2024
# Contact: aaronxiaozhou.liu@mail.utoronto.ca, jimmy.luc@mail.utoronto.ca, maroosh.gillani@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####

library(tidyverse)
library(dplyr)
library(ggplot2)
library(here)
library(haven)

#### Load data ####
# acquire fig 1 data from fig_1.csv
fig_1_data <- 
  read.csv(file=here("data/fig_1.csv"))

# acquire fig 2 a data from figs_2a_2b.csv
fig_2a_data <-
  read.csv((file=here("data/figs_2a_2b.csv")))

fig_2a_data <- fig_2a_data %>% select(year, brate_1519, brate_2024, brate_2529, brate_3034, brate_3539, brate_4044)

fig_2a_data_long <- fig_2a_data %>%
  pivot_longer(cols = -year, names_to = "Age_Group", values_to = "Birth_Rate")

# acquire fig 2 d data from figs_1_2_3.csv
fig_2d_data <-
  read.csv((file=here("data/figs_1_2_3.csv")))

fig_2d_data <- fig_2d_data %>% select(year, brate_hsdropout,	brate_hsgrad,	brate_somecol,	brate_colgrad)

fig_2d_data <- na.omit(fig_2d_data)

fig_2d_data_long <- fig_2d_data %>%
  pivot_longer(cols = -year, names_to = "Education_Level", values_to = "Birth_Rate")

# acquire fig 5 data from nchs_cohort_analysis.dta
nchs_cohort_data <- 
  read_dta(here("data/nchs_cohort_analysis.dta"))

# replicate figure 1 from the original paper
fig_1_data %>% ggplot(aes(x = year, y = brate_all)) +
  geom_line(color = "#378bd4", size = 1) +
  labs(x = "Year", y = "Births per 1,000 women age 15–44") +
  scale_y_continuous(limits = c(50,80), breaks = seq(50, 80, by = 5)) +
  scale_x_continuous(limits = c(1980,2020), breaks = seq(1980, 2020, by = 5)) +
  theme_classic()

# replicate figure 2a from the original paper
fig_2a_data_long %>% ggplot(aes(x = year, y = Birth_Rate, color = Age_Group)) +
  geom_line(size = 1) +
  labs(x = "Year", y = "Births per 1,000 women in relevant population subgroup", color = "Age Group", caption = "Five-year age group") +
  scale_y_continuous(limits = c(0, 140), breaks = seq(0, 150, by = 20)) +
  scale_x_continuous(limits = c(1980, 2020), breaks = seq(1980, 2020, by = 5)) +
  geom_text(aes(x = 1985, y = 120), label = "Age 25-29", color = "black") +
  geom_text(aes(x = 1985, y = 105), label = "Age 20-24", color = "black") +
  geom_text(aes(x = 1985, y = 80), label = "Age 30-34", color = "black") +
  geom_text(aes(x = 1985, y = 58), label = "Age 15-19", color = "black") +
  geom_text(aes(x = 1985, y = 33), label = "Age 35-39", color = "black") +
  geom_text(aes(x = 1985, y = 10), label = "Age 40-44", color = "black") +
  theme_classic() +
  theme(legend.position = "none")


# replicate figure 2d from the original paper
fig_2d_data_long %>% ggplot(aes(x = year, y = Birth_Rate, color = Education_Level)) +
  geom_line(size = 1) +
  labs(x = "Year", y = "Births per 1,000 women in relevant population subgroup", color = "Education Level", caption = "Mother’s level of education (ages 20–44)") +
  scale_y_continuous(limits = c(0, 140), breaks = seq(0, 150, by = 20)) +
  scale_x_continuous(limits = c(1990, 2020), breaks = seq(1990, 2020, by = 5)) +
  geom_text(aes(x = 1995, y = 105), label = "No high school degree", color = "black") +
  geom_text(aes(x = 1995, y = 75), label = "College graduate
", color = "#d44215") +
  theme_classic() +
  geom_text(aes(x = 1995, y = 65), label = "High school graduate", color = "#0cc4be") +
  geom_text(aes(x = 1995, y = 45), label = "Some college", color = "black") +
  theme_classic() +
  theme(legend.position = "none")





