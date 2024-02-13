#### Preamble ####
# Purpose: Tests data acquired from original AEA paper's replication package
# Author: Aaron Xiaozhou Liu, Jimmy Luc, Maroosh Gillani
# Date: 13 February 2024
# Contact: maroosh.gillani@mail.utoronto.ca, aaronxiaozhou.liu@mail.utoronto.ca, jimmy.luc@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have data downloaded


#### Workspace setup ####
library(tidyverse)
library(here)
library(haven)

#### Load in data ####
fig_1_data = read.csv(file=here("data/fig_1.csv"))
fig_2a_data = read.csv(file=here("data/figs_2a_2b.csv"))
fig_2d_data = read.csv(file=here("data/figs_1_2_3.csv"))
fig_2f_data_1 = read_dta(here("data/nchs_births_pop_1990_2019.dta"))
fig_2f_data_2 = read_dta(here("data/age_race_comp_seer.dta"))
fig_5_data_1 = read_dta(here("data/agecomp-seer.dta"))
fig_5_data_2 = read_dta(here("data/nchs_cohort_analysis.dta"))

#### Test data ####
## test data types
# methods used: https://stackoverflow.com/a/29591221
all(sapply(fig_1_data$year, is.numeric))
all(sapply(fig_1_data$brate_all, is.numeric))

all(sapply(fig_2a_data$year, is.numeric))
all(sapply(fig_2a_data$brate_1519, is.numeric))
all(sapply(fig_2a_data$brate_2024, is.numeric))
all(sapply(fig_2a_data$brate_2529, is.numeric))
all(sapply(fig_2a_data$brate_3034, is.numeric))
all(sapply(fig_2a_data$brate_3539, is.numeric))
all(sapply(fig_2a_data$brate_4044, is.numeric))

all(sapply(fig_2d_data$year, is.numeric))
all(sapply(fig_2d_data$brate_hsdropout, is.numeric)) # is.numeric ignores NA values
all(sapply(fig_2d_data$brate_hsgrad, is.numeric))
all(sapply(fig_2d_data$brate_somecol, is.numeric))
all(sapply(fig_2d_data$brate_colgrad, is.numeric))

all(sapply(fig_2f_data_1$year, is.numeric))
all(sapply(fig_2f_data_1$stname, is.character))
all(sapply(fig_2f_data_1$numbirth_firstbirth, is.numeric))
all(sapply(fig_2f_data_1$numbirth_secondbirth, is.numeric))
all(sapply(fig_2f_data_1$numbirth_thirdbirth, is.numeric))
all(sapply(fig_2f_data_1$numbirth_fourthbirth, is.numeric))
all(sapply(fig_2f_data_1$pop1544, is.numeric))

all(sapply(fig_2f_data_2$year, is.numeric))

all(sapply(fig_5_data_1$year, is.numeric))
all(sapply(fig_5_data_1$stname, is.character))
all(sapply(fig_5_data_1$fem15, is.numeric))
all(sapply(fig_5_data_1$fem44, is.numeric))

all(sapply(fig_5_data_2$mage, is.numeric))
all(sapply(fig_5_data_2$cohort2, is.numeric))
all(sapply(fig_5_data_2$numbirth, is.numeric))


## test data values
min(fig_1_data$year) == 1980 && max(fig_1_data$year) == 2020
