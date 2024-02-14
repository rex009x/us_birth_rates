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
## Figure 2a ##
# acquire figure 2a data from figs_2a_2b.csv
fig_2a_data <-
  read.csv(file=here("data/figs_2a_2b.csv"))

fig_2a_data <- fig_2a_data %>% select(year, brate_1519, brate_2024, brate_2529, brate_3034, brate_3539, brate_4044)

fig_2a_data_long <- fig_2a_data %>%
  pivot_longer(cols = -year, names_to = "Age_Group", values_to = "Birth_Rate")

# replicate figure 2a from the original paper
fig_2a_data_long %>% ggplot(aes(x = year, y = Birth_Rate, color = Age_Group)) +
  geom_line(size = 1) +
  labs(x = "Year", y = "Births per 1,000 women in \n relevant population subgroup", color = "Age Group") +
  scale_y_continuous(limits = c(0, 140), breaks = seq(0, 150, by = 20)) +
  scale_x_continuous(limits = c(1980, 2020), breaks = seq(1980, 2020, by = 5)) +
  geom_text(aes(x = 1985, y = 120), label = "Age 25-29", color = "#00ba38") +
  geom_text(aes(x = 1985, y = 100), label = "Age 20-24", color = "#b79f00") +
  geom_text(aes(x = 1985, y = 80), label = "Age 30-34", color = "#00bfc4") +
  geom_text(aes(x = 1985, y = 58), label = "Age 15-19", color = "#f8766d") +
  geom_text(aes(x = 1985, y = 33), label = "Age 35-39", color = "#619cff") +
  geom_text(aes(x = 1985, y = 10), label = "Age 40-44", color = "#f564e3") +
  theme_classic() +
  theme(legend.position = "none")

## Figure 2d ##
# acquire figure 2d data from figs_1_2_3.csv
fig_2d_data <-
  read.csv(file=here("data/figs_1_2_3.csv"))

fig_2d_data <- fig_2d_data %>% select(year, brate_hsdropout,	brate_hsgrad,	brate_somecol,	brate_colgrad)

fig_2d_data <- na.omit(fig_2d_data)

fig_2d_data_long <- fig_2d_data %>%
  pivot_longer(cols = -year, names_to = "Education_Level", values_to = "Birth_Rate")

# replicate figure 2d from the original paper
fig_2d_data_long %>% ggplot(aes(x = year, y = Birth_Rate, color = Education_Level)) +
  geom_line(size = 1) +
  labs(x = "Year", y = "Births per 1,000 women in \n relevant population subgroup", color = "Education Level") +
  scale_y_continuous(limits = c(0, 140), breaks = seq(0, 150, by = 20)) +
  scale_x_continuous(limits = c(1990, 2020), breaks = seq(1990, 2020, by = 5)) +
  geom_text(aes(x = 1993, y = 112), label = "No high school degree", color = "#7cae00", hjust = 0) +
  geom_text(aes(x = 1993, y = 82), label = "College graduate", color = "#f8766d", hjust = 0) +
  theme_classic() +
  geom_text(aes(x = 1993, y = 62), label = "High school graduate", color = "#00bfc4", hjust = 0) +
  geom_text(aes(x = 1993, y = 45), label = "Some college", color = "#c77cff", hjust = 0) +
  theme_classic() +
  theme(legend.position = "none")

## Figure 2f ##
# acquire figure 2f data from NCHS Natality Microdata's nchs_births_pop_1990_2019.dta and SEER's age_race_comp_seer.dta
nchs_births_data <- read_dta(here("data/nchs_births_pop_1990_2019.dta"))
seer_data <- read_dta(here("data/age_race_comp_seer.dta"))

merged_data <- merge(nchs_births_data, seer_data, by = c("stname", "year"))

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

# replicate figure 2f from the original paper
merged_data_long %>% ggplot(aes(x = year, y = round(Birth_Rate, digits = 1), color = Parity)) +
  geom_line(size = 1, stat = "summary", fun = mean) +
  labs(x = "Year", y = "Births per 1,000 women in \n relevant population subgroup", color = "Parity") +
  scale_y_continuous(limits = c(0, 40), breaks = seq(0, 40, by = 10)) +
  scale_x_continuous(limits = c(1990, 2020), breaks = seq(1990, 2020, by = 5)) +
  geom_text(aes(x = 1993, y = 28), label = "First birth", color = "#f8766d", hjust = 0) +
  geom_text(aes(x = 1993, y = 23), label = "Second birth", color = "#00bfc4", hjust = 0) +
  geom_text(aes(x = 1993, y = 12.5), label = "Third Birth", color = "#c77cff", hjust = 0) +
  geom_text(aes(x = 1993, y = 8.5), label = "Fourth+ birth", color = "#7cae00", hjust = 0) +
  theme_classic() +
  theme(legend.position = "none")

### Figure 5 ###
# acquire figure 5 data from CDC SEER's agecomp-seer.dta
seer_cohort_data <- 
  read_dta(here("data/agecomp-seer.dta"))

nchs_cohort_data <- 
  read_dta(here("data/nchs_cohort_analysis.dta"))

# code to replicate figure 5 from: https://github.com/KCtt457/us-birth-rates-decline
# Process population data to aggregate by cohort
fig5_pop_data1 <- seer_cohort_data %>%
  select(1:32) %>%
  select(-c(stname)) %>%
  group_by(year) %>%
  summarise(across(everything(),sum)) # https://stackoverflow.com/questions/1660124/how-to-sum-a-variable-by-group

fig5_pop_data1 <- fig5_pop_data1 %>%
  pivot_longer(-c(year), names_to = "mage", values_to = "pop")

fig5_pop_data1 <- fig5_pop_data1 %>%
  mutate(mage = as.numeric(str_replace(mage, "fem", ""))) %>%
  mutate(cohort = year - mage) %>%
  mutate(cohort2 = case_when(cohort >= 1968 & cohort <=1972 ~ 1,
                             cohort >= 1973 & cohort <=1977 ~ 2,
                             cohort >= 1978 & cohort <=1982 ~ 3,
                             cohort >= 1983 & cohort <=1987 ~ 4,
                             cohort >= 1988 & cohort <=1992 ~ 5,
                             cohort >= 1993 & cohort <=1997 ~ 6))

fig5_pop_data1 <- na.omit(fig5_pop_data1)
fig5_pop_data1 <- fig5_pop_data1 %>%
  group_by(cohort2, mage) %>%
  summarise(pop = sum(pop))

# Join dataframes for population and birth data
nchs_cohort_data <- full_join(nchs_cohort_data, fig5_pop_data1, by=c("mage", "cohort2")) %>%
  mutate(cohort_years = case_when(cohort2 == 1 ~ "1968-1972",
                                  cohort2 == 2 ~ "1973-1977",
                                  cohort2 == 3 ~ "1978-1982",
                                  cohort2 == 4 ~ "1983-1987",
                                  cohort2 == 5 ~ "1988-1992",
                                  cohort2 == 6 ~ "1993-1997"))

# replicate figure 5 from the original paper
# Calculate birth rates
nchs_cohort_data <- nchs_cohort_data %>%
  mutate(brate=numbirth/pop*1000,
         age_20_24_year = case_when(cohort2 == 1 ~ 1992,
                                    cohort2 == 2 ~ 1997,
                                    cohort2 == 3 ~ 2002,
                                    cohort2 == 4 ~ 2007,
                                    cohort2 == 5 ~ 2012,
                                    cohort2 == 6 ~ 2017)
  )

# Calculate cumulative birth rates for each cohort
nchs_cohort_data <- nchs_cohort_data %>%
  group_by(cohort2) %>%
  mutate(cum_brate = cumsum(brate)/1000, 
         cohort_years = case_when(cohort2 == 1 ~ "1968-1972",
                                  cohort2 == 2 ~ "1973-1977",
                                  cohort2 == 3 ~ "1978-1982",
                                  cohort2 == 4 ~ "1983-1987",
                                  cohort2 == 5 ~ "1988-1992",
                                  cohort2 == 6 ~ "1993-1997")) 
# Make plot (Figure 5 replication)
nchs_cohort_data %>%
  ggplot(aes(x = mage,
             y = cum_brate,
             color = cohort_years)) +
  geom_line(size = 1) +
  labs(x = "Mother's age", y = "Children ever born", color = "Birth cohorts") +
  scale_y_continuous(limits=c(0, 2.5), breaks=seq(0, 2.5, by = .5)) +
  scale_x_continuous(limits=c(15, 44), breaks=seq(15, 44, by = 1)) +
  theme_classic() + 
  theme(legend.background = element_blank(), legend.box.background = element_rect(), legend.position = c(0.85,0.4), axis.text.x = element_text(angle = 45, hjust = 1))
