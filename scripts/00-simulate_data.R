#### Preamble ####
# Purpose: Simulates and tests the data that will be required to reproduce the figures
# Author: Aaron Xiaozhou Liu, Jimmy Luc, Maroosh Gillani
# Date: 14 February 2024
# Contact: maroosh.gillani@mail.utoronto.ca, aaronxiaozhou.liu@mail.utoronto.ca, jimmy.luc@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# set seed for simulation
set.seed(416)

# simulate figure 1 data - Trend in US birth rates from 1980 to 2020
# methods used: https://stackoverflow.com/a/68763213
fig_1_years = 1980:2020
fig_1_brate_mean = 65
fig_1_brate_sd = 2
simulate_fig_1 <-
  tibble(
    year = fig_1_years,
    brate_all = rnorm(n = fig_1_years, mean = fig_1_brate_mean, sd = fig_1_brate_sd)
    )

# simulate figure 2a data - Trend in birth rates by five-year age group
fig_2a_years = 1980:2020
simulate_fig_2a <-
  tibble(
    year = fig_2a_years,
    brate_1519 = rnorm(fig_2a_years, mean = 40, sd = 7),
    brate_2024 = rnorm(fig_2a_years, mean = 100, sd = 7),
    brate_2529 = rnorm(fig_2a_years, mean = 110, sd = 5),
    brate_3034 = rnorm(fig_2a_years, mean = 90, sd = 10),
    brate_3539 = rnorm(fig_2a_years, mean = 40, sd = 10),
    brate_4044 = rnorm(fig_2a_years, mean = 5, sd = 2)
  )

# simulate figure 2d data - Trend in birth rate by mother's level of education
fig_2d_years = 1990:2020
simulate_fig_2d <-
  tibble(
    year = fig_2d_years,
    brate_hsdropout = rnorm(fig_2d_years, mean = 105, sd = 12),
    brate_hsgrad = rnorm(fig_2d_years, mean = 75, sd = 5),
    brate_somecol = rnorm(fig_2d_years, mean = 55, sd = 10),
    brate_colgrad = rnorm(fig_2d_years, mean = 70, sd = 5)
  )

# simulate figure 2f data - Trend in birth rates by parity (number of children for a given woman)
fig_2f_years = 1990:2020
simulate_fig_2f <-
  tibble(
    year = fig_2f_years,
    numbirth_firstbirth = rnorm(fig_2f_years, mean = 27, sd = 2),
    numbirth_secondbirth = rnorm(fig_2f_years, mean = 21, sd = 1),
    numbirth_thirdbirth = rnorm(fig_2f_years, mean = 11, sd = 0.5),
    numbirth_fourthbirth = rnorm(fig_2f_years, mean = 9, sd = 0.5)
  )

# simulate figure 5 data - Number of children ever born by mother's age and birth cohort
fig_5_motherage = 15:44
simulate_fig_5 <-
  tibble(
    mage = fig_5_motherage,
    cohort2 = rep(1:6, each = 5, length.out = length(fig_5_motherage)),
    numbirth = rnorm(fig_5_motherage, mean = 700000, sd = 200000)
  )

#### Test data ####
## test data types##
# methods used: https://stackoverflow.com/a/29591221
all(sapply(simulate_fig_1$year, is.numeric))
all(sapply(simulate_fig_1$brate_all, is.numeric))

all(sapply(simulate_fig_2a$year, is.numeric))
all(sapply(simulate_fig_2a$brate_1519, is.numeric))
all(sapply(simulate_fig_2a$brate_2024, is.numeric))
all(sapply(simulate_fig_2a$brate_2529, is.numeric))
all(sapply(simulate_fig_2a$brate_3034, is.numeric))
all(sapply(simulate_fig_2a$brate_3539, is.numeric))
all(sapply(simulate_fig_2a$brate_4044, is.numeric))

all(sapply(simulate_fig_2d$year, is.numeric))
all(sapply(simulate_fig_2d$brate_hsdropout, is.numeric)) # is.numeric ignores NA values
all(sapply(simulate_fig_2d$brate_hsgrad, is.numeric))
all(sapply(simulate_fig_2d$brate_somecol, is.numeric))
all(sapply(simulate_fig_2d$brate_colgrad, is.numeric))

all(sapply(simulate_fig_2f$year, is.numeric))
all(sapply(simulate_fig_2f$numbirth_firstbirth, is.numeric))
all(sapply(simulate_fig_2f$numbirth_secondbirth, is.numeric))
all(sapply(simulate_fig_2f$numbirth_thirdbirth, is.numeric))
all(sapply(simulate_fig_2f$numbirth_fourthbirth, is.numeric))

all(sapply(simulate_fig_5$mage, is.numeric))
all(sapply(simulate_fig_5$cohort2, is.numeric))
all(sapply(simulate_fig_5$numbirth, is.numeric))


## test data values ##
all(simulate_fig_1$year >= 1980 & simulate_fig_1$year <= 2020)
all(simulate_fig_1$brate_all >= 0) # cannot have negative birth rate

all(simulate_fig_2a$year >= 1980 & simulate_fig_2a$year <= 2020)
all(simulate_fig_2a$brate_1519 >= 0) # cannot have negative birth rate
all(simulate_fig_2a$brate_2024 >= 0)
all(simulate_fig_2a$brate_2529 >= 0)
all(simulate_fig_2a$brate_3034 >= 0)
all(simulate_fig_2a$brate_3539 >= 0)
all(simulate_fig_2a$brate_4044 >= 0)

# data contains empty entries
all(simulate_fig_2d$year >= 1980 & simulate_fig_2d$year <= 2020, na.rm = TRUE)
all(simulate_fig_2d$brate_hsdropout >= 0, na.rm = TRUE) # cannot have negative birth rate
all(simulate_fig_2d$brate_hsgrad >= 0, na.rm = TRUE)
all(simulate_fig_2d$brate_somecol >= 0, na.rm = TRUE)
all(simulate_fig_2d$brate_colgrad >= 0, na.rm = TRUE)

all(simulate_fig_2f$year >= 1990 & simulate_fig_2f$year <= 2020)
all(simulate_fig_2f$numbirth_firstbirth >= 0) # cannot have negative number of births
all(simulate_fig_2f$numbirth_secondbirth >= 0)
all(simulate_fig_2f$numbirth_thirdbirth >= 0)
all(simulate_fig_2f$numbirth_fourthbirth >= 0)

all(simulate_fig_5$mage >= 15 & simulate_fig_5$mage <= 44)
all(simulate_fig_5$cohort2 >= 1 & simulate_fig_5$cohort2 <= 6)
all(simulate_fig_5$numbirth >= 0) # cannot have negative number of births
