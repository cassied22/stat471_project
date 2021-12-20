# load libraries
library(lubridate)
library(tidyverse)

# load raw case data
co2_raw = read_csv(file = "data/raw/co2-data.csv")
head(co2_raw)
# clean case data
co2_raw = co2_raw %>%
  filter(year >= 2010 & year <= 2020) %>%     # keep data from 2010 to 2020
  select(iso_code, country, year, co2_per_capita) %>%  # keep country, iso_code, year, co2_per_capita columns
  na.omit() 
co2_raw

# load raw county health data
# (omitted from this template)

# clean county health data
# (omitted from this template, reading from file instead)
county_health_data = read_tsv("data/raw/county_health_data.tsv")

# join county health data with case data
covid_data = inner_join(county_health_data, case_data, by = "fips")

# write cleaned data to file
write_tsv(covid_data, file = "data/clean/covid_data.tsv")