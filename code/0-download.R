# load libraries
library(tidyverse)
library (readr)

# download CO2 data from Our Wolrd In Data Website 
# (https://ourworldindata.org/co2-emissions)

url = "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
co2_raw = read_csv(url)
co2_raw


# write C02 raw data to file
write_csv(x = co2_raw, file = "data/raw/co2_data_raw.csv")

#The environmental/economic/social indicators datasets are donwnloaded from the 
# WorldBank website  (https://data.worldbank.org/indicator)
# This website contains data for various different indicators for
# different countries in different years. The 15 indicators I chose include
# mainly 5 categories: Climate Change, Economy&Growth, Energy/Mining, and
# Environment, Poverty
# The 18 indicators are: 1, GDP per capita; 2,Industry(value added % of GDP); 
# 3, Agriculture, forestry, and fishing, value added (% of GDP);
# 4, Agricultural land (% of land area); 5, Forest area (% of land area);
# 6, Mortality rate, under-5 (per 1,000 live births), 
# 7, Terrestrial and marine protected areas (% of total territorial area),
# 8, Urban population (% of total population)
# 9, Alternative and nuclear energy (% of total energy use)
# 10, Fossil fuel energy consumption (% of total)
# 11, Renewable energy consumption (% of total final energy consumption),
# 12, Arable land (% of land area);
# 13, Total natural resources rents (% of GDP)
# 14, Gini index (World Bank estimate)
# 15, Birth rate, crude (per 1,000 people)
# 16, Exports of goods and services (% of GDP)


