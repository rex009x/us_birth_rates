#### Preamble ####
# Purpose: Simulates the data that will be required to reproduce the figures
# Author: Aaron Xiaozhou Liu, Jimmy Luc, Maroosh Gillani
# Date: 14 February 2024
# Contact: maroosh.gillani@mail.utoronto.ca, aaronxiaozhou.liu@mail.utoronto.ca, jimmy.luc@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# set seed for simulation
set.seed(416)

# simulate figure 1 data
# methods used: https://stackoverflow.com/a/68763213
fig_1_years = 1980:2020
fig_1_brate_mean = 65
fig_1_brate_sd = 2
simulate_fig_1 <-
  tibble(
    year = fig_1_years,
    brate_all = rnorm(n = fig_1_years, mean = fig_1_brate_mean, sd = fig_1_brate_sd)
    )

# simulate figure 2a data
fig_2a_years = 1980:2020
simulate_fig_2a <-
  tibble(
    year = fig_2a_years,
    brate_1519 = rnorm(fig_2a_years, mean = 40, sd = 7),
    brate_2024 = rnorm(fig_2a_years, mean = 100, sd = 7),
    brate_2529 = rnorm(fig_2a_years, mean = 110, sd = 5),
    brate_3034 = rnorm(fig_2a_years, mean = 90, sd = 10),
    brate_3539 = rnorm(fig_2a_years, mean = 40, sd = 10),
    brate_4044 = rnorm(fig_2a_years, mean = 5, sd = 5)
  )

# simulate figure 2d data
fig_2d_years = 1990:2020
simulate_fig_2d <-
  tibble(
    year = fig_2d_years,
    brate_hsdropout = rnorm(fig_2d_years, mean = 105, sd = 12),
    brate_hsgrad = rnorm(fig_2d_years, mean = 75, sd = 5),
    brate_somecol = rnorm(fig_2d_years, mean = 55, sd = 10),
    brate_colgrad = rnorm(fig_2d_years, mean = 70, sd = 5)
  )

# simulate figure 2f data
fig_2f_years = 1990:2020
simulate_fig_2f <-
  tibble(
    year = fig_2f_years,
    numbirth_firstbirth = rnorm(fig_2f_years, mean = 27, sd = 2),
    numbirth_secondbirth = rnorm(fig_2f_years, mean = 21, sd = 1),
    numbirth_thirdbirth = rnorm(fig_2f_years, mean = 11, sd = 0.5),
    numbirth_fourthbirth = rnorm(fig_2f_years, mean = 9, sd = 0.5)
  )

# simulate figure 5 data
fig_5_motherage = 15:44
simulate_fig_5 <-
  tibble(
    mage = fig_5_motherage,
    cohort2 = rep(1:6, each = 5, length.out = length(fig_5_motherage)),
    numbirth = rnorm(fig_5_motherage, mean = 700000, sd = 200000)
  )
