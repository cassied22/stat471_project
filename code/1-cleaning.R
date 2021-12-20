# load libraries
library(lubridate)
library(tidyverse)

# load raw case data
co2_raw = read_csv("data/raw/co2_data_raw.csv")
head(co2_raw)
# clean case data
co2_raw = co2_raw %>%
  filter(year >= 2000 & year <= 2020) %>%     # keep data from 2000 to 2020
  select(iso_code, country, year, co2_per_capita) %>%  # keep country, iso_code, year, co2_per_capita columns
  na.omit() 
co2_raw


# clean data for all indicators and join them with co2 data

# clean birth rate data (1)
birth_rate = read_csv("data/raw/birth_rate_raw.csv", skip = 4)
birth_rate = birth_rate%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "Birth_rate")%>% 
                select(-c('Indicator Name', 'Indicator Code'))%>%
                                    na.omit() 
  
  
birth_rate$Year = as.numeric(birth_rate$Year)
birth_rate = birth_rate%>%filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
birth_rate               

# join birth rate data with co2 data
co2_data = inner_join(co2_raw, birth_rate, 
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean agricultural land data (2)
agriculture_land = read_csv("data/raw/agricultural_land_raw.csv", skip = 4)
agriculture_land = agriculture_land%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "agriculture_land")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


agriculture_land$Year = as.numeric(agriculture_land$Year)
agriculture_land = agriculture_land%>%filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
agriculture_land  

# join agricultural data with co2 data
co2_data = inner_join(co2_data, agriculture_land, 
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean agriculture value added data (3)
agriculture_value_added = read_csv("data/raw/agriculture_raw.csv", skip = 4)
agriculture_value_added = agriculture_value_added%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "agriculture_value_added")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


agriculture_value_added$Year = as.numeric(agriculture_value_added$Year)
agriculture_value_added = agriculture_value_added%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
agriculture_value_added

# join agriculture value added data with co2 data
co2_data = inner_join(co2_data, agriculture_value_added, 
                      by = c("iso_code" = "country_code", 
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean alternative_energy data (4)
alternative_energy = read_csv("data/raw/alternative_energy_raw.csv", skip = 4)
alternative_energy = alternative_energy%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "alternative_energy")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


alternative_energy$Year = as.numeric(alternative_energy$Year)
alternative_energy = alternative_energy%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
alternative_energy

# join agriculture value added data with co2 data
co2_data = inner_join(co2_data, alternative_energy,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean arable_land data (5)
arable_land = read_csv("data/raw/arable_land_raw.csv", skip = 4)
arable_land = arable_land%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "arable_land")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


arable_land$Year = as.numeric(arable_land$Year)
arable_land = arable_land%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
arable_land

# join agriculture value added data with co2 data
co2_data = inner_join(co2_data, arable_land,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean export data (6)
export = read_csv("data/raw/export_raw.csv", skip = 4)
export = export%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "export")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


export$Year = as.numeric(export$Year)
export = export%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
export

# join export data with co2 data
co2_data = inner_join(co2_data, export,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean forest data (7)
forest = read_csv("data/raw/forest_raw.csv", skip = 4)
forest = forest%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "forest")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


forest$Year = as.numeric(forest$Year)
forest = forest%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
forest

# join forest data with co2 data
co2_data = inner_join(co2_data, forest,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean fossil_fuel data (8)
fossil_fuel = read_csv("data/raw/fossil_fuel_raw.csv", skip = 4)
fossil_fuel = fossil_fuel%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "fossil_fuel")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


fossil_fuel$Year = as.numeric(fossil_fuel$Year)
fossil_fuel = fossil_fuel%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
fossil_fuel

# join fossil_fuel data with co2 data
co2_data = inner_join(co2_data,fossil_fuel,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean gdp data (9)
gdp = read_csv("data/raw/gdp_raw.csv", skip = 4)
gdp = gdp%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "gdp")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


gdp$Year = as.numeric(gdp$Year)
gdp = gdp%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
gdp

# join gdp data with co2 data
co2_data = inner_join(co2_data,gdp,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean industry data (10)
industry = read_csv("data/raw/industry_raw.csv", skip = 4)
industry = industry%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "industry")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


industry$Year = as.numeric(industry$Year)
industry = industry%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
industry

# join industry data with co2 data
co2_data = inner_join(co2_data,industry,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean mortality data (11)
mortality = read_csv("data/raw/mortality_raw.csv", skip = 4)
mortality = mortality%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "mortality")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


mortality$Year = as.numeric(mortality$Year)
mortality = mortality%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
mortality

# join mortality data with co2 data
co2_data = inner_join(co2_data,mortality,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean natural_resources data (12)
natural_resources = read_csv("data/raw/natural_resources_raw.csv", skip = 4)
natural_resources = natural_resources%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "natural_resources")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


natural_resources$Year = as.numeric(natural_resources$Year)
natural_resources = natural_resources%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
natural_resources

# join natural_resources data with co2 data
co2_data = inner_join(co2_data,natural_resources,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean renewable_energy data (13)
renewable_energy = read_csv("data/raw/renewable_energy_raw.csv", skip = 4)
renewable_energy = renewable_energy%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "renewable_energy")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


renewable_energy$Year = as.numeric(renewable_energy$Year)
renewable_energy = renewable_energy%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
renewable_energy

# join renewable_energy data with co2 data
co2_data = inner_join(co2_data,renewable_energy,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean unemployment data (14)
unemployment = read_csv("data/raw/unemployment_raw.csv", skip = 4)
unemployment = unemployment%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "unemployment")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


unemployment$Year = as.numeric(unemployment$Year)
unemployment = unemployment%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
unemployment

# join unemployment data with co2 data
co2_data = inner_join(co2_data,unemployment,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data

# clean import data (15)
import = read_csv("data/raw/import_raw.csv", skip = 4)
import = import%>%
  pivot_longer(!c('Country Name', 'Country Code', 'Indicator Name', 
                  'Indicator Code'), names_to = "Year", 
               values_to = "import")%>% 
  select(-c('Indicator Name', 'Indicator Code'))%>%
  na.omit() 


import$Year = as.numeric(import$Year)
import = import%>%
  filter(Year >= 2000 & Year <= 2020) %>%
  rename(Country = 'Country Name',country_code =  'Country Code', year = Year)
import

# join import data with co2 data
co2_data = inner_join(co2_data,import,
                      by = c("iso_code" = "country_code",
                             "year" = "year"))

co2_data = co2_data %>% select(-Country)
co2_data



co2_data$country_year = paste(co2_data$country, "-",as.character(co2_data$year))



co2_data <- co2_data %>%
  select(country_year, everything())


# write cleaned data to file
write_csv(co2_data, file = "data/clean/co2_data.csv")

