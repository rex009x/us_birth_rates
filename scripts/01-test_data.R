#### Preamble ####
# Purpose: Tests data acquired from original AEA article replication package
# Author: Aaron Xiaozhou Liu, Jimmy Luc, Maroosh Gillani
# Date: 14 February 2024
# Contact: maroosh.gillani@mail.utoronto.ca, aaronxiaozhou.liu@mail.utoronto.ca, jimmy.luc@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have the data downloaded
# Additional Information: These tests are applicable to the simulated data in 00-simulate_data.R


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
## test data types##
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


## test data values ##
all(fig_1_data$year >= 1980 & fig_1_data$year <= 2020)
all(fig_1_data$brate_all >= 0) # cannot have negative birth rate


all(fig_2a_data$year >= 1980 & fig_2a_data$year <= 2020)
all(fig_2a_data$brate_1519 >= 0) # cannot have negative birth rate
all(fig_2a_data$brate_2024 >= 0)
all(fig_2a_data$brate_2529 >= 0)
all(fig_2a_data$brate_3034 >= 0)
all(fig_2a_data$brate_3539 >= 0)
all(fig_2a_data$brate_4044 >= 0)

# data contains empty entries
all(fig_2d_data$year >= 1980 & fig_2d_data$year <= 2020, na.rm = TRUE)
all(fig_2d_data$brate_hsdropout >= 0, na.rm = TRUE) # cannot have negative birth rate
all(fig_2d_data$brate_hsgrad >= 0, na.rm = TRUE)
all(fig_2d_data$brate_somecol >= 0, na.rm = TRUE)
all(fig_2d_data$brate_colgrad >= 0, na.rm = TRUE)


all(fig_2f_data_1$year >= 1990 & fig_2f_data_1$year <= 2019)
all(fig_2f_data_1$stname != '')
all(fig_2f_data_1$numbirth_firstbirth >= 0) # cannot have negative number of births
all(fig_2f_data_1$numbirth_secondbirth >= 0)
all(fig_2f_data_1$numbirth_thirdbirth >= 0)
all(fig_2f_data_1$numbirth_fourthbirth >= 0)
all(fig_2f_data_1$pop1544 >= 0) # cannot have negative births


all(fig_2f_data_2$year >= 1990 & fig_2f_data_2$year <= 2019)

all(fig_5_data_1$year >= 1980 & fig_5_data_1$year <= 2019)
all(fig_5_data_1$stname != '') # all entries have an associated US state
all(fig_5_data_1$fem15 >= 0) # cannot have negative population
all(fig_5_data_1$fem44 >= 0)

all(fig_5_data_2$mage >= 15 & fig_5_data_2$mage <= 44)
all(fig_5_data_2$cohort2 >= 1 & fig_5_data_2$cohort2 <= 6)
all(fig_5_data_2$numbirth >= 0) # cannot have negative number of births
