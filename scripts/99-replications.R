#### Preamble ####
# Purpose: Replication of figures in the original paper
# Author: Aaron Xiaozhou Liu, Jimmy Luc, Maroosh Gillani
# Date: 12 February 2024
# Contact: maroosh.gillani@mail.utoronto.ca, aaronxiaozhou.liu@mail.utoronto.ca, jimmy.luc@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have data downloaded


#### Workspace setup ####

library(tidyverse)
library(dplyr)
library(ggplot2)
library(here)
library(haven)

#### Load data ####

### Figure 1 ###
# acquire figure 1 data from fig_1.csv
fig_1_data <- 
  read.csv(file=here("data/fig_1.csv"))

# replicate figure 1 from the original paper
fig_1_data %>% ggplot(aes(x = year, y = brate_all)) +
  geom_line(color = "#378bd4", size = 1) +
  labs(x = "Year", y = "Births per 1,000 women age 15-44") +
  scale_y_continuous(limits = c(50,80), breaks = seq(50, 80, by = 5)) +
  scale_x_continuous(limits = c(1980,2020), breaks = seq(1980, 2020, by = 5)) +
  theme_classic()

### Figure 2 ###
## Figure 2A ##
# acquire figure 2A data from figs_2a_2b.csv
fig_2a_data <-
  read.csv(file=here("data/figs_2a_2b.csv"))

fig_2a_data <- fig_2a_data %>% select(year, brate_1519, brate_2024, brate_2529, brate_3034, brate_3539, brate_4044)

fig_2a_data_long <- fig_2a_data %>%
  pivot_longer(cols = -year, names_to = "Age_Group", values_to = "Birth_Rate")

# replicate figure 2A from the original paper
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

## Figure 2D ##
# acquire figure 2D data from figs_1_2_3.csv
fig_2d_data <-
  read.csv(file=here("data/figs_1_2_3.csv"))

fig_2d_data <- fig_2d_data %>% select(year, brate_hsdropout,	brate_hsgrad,	brate_somecol,	brate_colgrad)

fig_2d_data <- na.omit(fig_2d_data)

fig_2d_data_long <- fig_2d_data %>%
  pivot_longer(cols = -year, names_to = "Education_Level", values_to = "Birth_Rate")

# replicate figure 2D from the original paper
fig_2d_data_long %>% ggplot(aes(x = year, y = Birth_Rate, color = Education_Level)) +
  geom_line(size = 1) +
  labs(x = "Year", y = "Births per 1,000 women in relevant population subgroup", color = "Education Level", caption = "Mother's level of education (ages 20-44)") +
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

## Figure 2F ##
# acquire figure 2F data from NCHS Natality Microdata's nchs_births_pop_1990_2019.dta and SEER's age_race_comp_seer.dta
nchs_births_data <- read_dta(here("data/nchs_births_pop_1990_2019.dta"))
seer_data <- read_dta(here("data/age_race_comp_seer.dta"))

merged_data <- merge(nchs_data, seer_data, by = c("stname", "year"))

merged_data <- merged_data %>%
  mutate(
    brate_firstbirth = merged_data$numbirth_firstbirth / merged_data$pop1544 * 1000,
    brate_secondbirth = merged_data$numbirth_secondbirth / merged_data$pop1544 * 1000,
    brate_thirdbirth = merged_data$numbirth_thirdbirth / merged_data$pop1544 * 1000,
    brate_fourthbirth = merged_data$numbirth_fourthbirth / merged_data$pop1544 * 1000
  ) %>%
  select(year, starts_with("brate_"))

merged_data_long <- merged_data %>%
  pivot_longer(cols = -year, names_to = "Parity", values_to = "Birth_Rate")

# replicate figure 2F from the original paper
merged_data_long %>% ggplot(aes(x = year, y = round(Birth_Rate, digits = 1), color = Parity)) +
  geom_line(size = 1, stat = "summary", fun = mean) +
  labs(x = "Year", y = "Births per 1,000 women in relevant population subgroup", color = "Parity", caption = "Parity (ages 15-44)") +
  scale_y_continuous(limits = c(0, 40), breaks = seq(0, 40, by = 10)) +
  scale_x_continuous(limits = c(1990, 2020), breaks = seq(1990, 2020, by = 5)) +
  geom_text(aes(x = 1995, y = 30), label = "First birth", color = "black") +
  geom_text(aes(x = 1995, y = 25), label = "Second birth", color = "black") +
  geom_text(aes(x = 1995, y = 15), label = "Third Birth", color = "black") +
  geom_text(aes(x = 1995, y = 10), label = "Fourth+ birth", color = "black") +
  theme_classic() +
  theme(legend.position = "none")

### Figure 5 ###
# acquire figure 5 data from NCHS Natality Microdata's nchs_cohort_analysis.dta
nchs_cohort_data <- 
  read_dta(here("data/nchs_cohort_analysis.dta"))
