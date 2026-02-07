library(readr)
library(dplyr)
library(stringr)
library(janitor)
library(here)


staged_turnout <- readRDS(here("data", "processed", "staged_turnout.rds"))

county_turnout <- staged_turnout %>%
  janitor::clean_names() %>%
  # retain only county-years with sufficient data to calculcate turnout_rate metric
  filter(
    !is.na(ballots_cast), # reported ballot counts
    !is.na(cvap), # reported citizen voting-age population
    cvap > 0 # avoid division by zero
  ) %>%
  rename(
    county_fips = stcofips10
  ) %>%
  mutate(
    # county turnout rate defined as ballots cast divided by citizen voting-age population (CVAP)
    turnout_rate = ballots_cast / cvap,

    # extract two-digit state FIPS from county FIPS code
    state_fips = str_sub(county_fips, 1, 2)
  ) %>%
  select(
    county_fips,
    state_fips,
    year,
    ballots_cast,
    cvap,
    turnout_rate
  )

saveRDS(county_turnout, here("data", "processed", "county_turnout.rds"))
