library(readr)
library(here)

# load in raw data
staged_turnout <- read_tsv(
  here("data", "raw", "icpsr", "county_turnout_icpsr.tsv")
)

# save staged data - to be loaded into 02_clean_validate
saveRDS(staged_turnout, here("data", "processed", "staged_turnout.rds"))
