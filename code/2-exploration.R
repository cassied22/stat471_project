# load libraries
library(kableExtra)                     # for printing tables
library(cowplot)                        # for side by side plots
library(lubridate)                      # for dealing with dates
library(maps)                           # for creating maps
library(tidyverse)

# read in the cleaned data
co2_data = read_csv("data/clean/co2_data.csv")
co2_data

# calculate summary statistics for CO2 emission per capita

fivenum_co2 = fivenum(co2_data$co2_per_capita)

fivenum_co2
median_co2 = fivenum_co2[3]

min_co2 = fivenum_co2[1]

max_co2 = fivenum_co2[5]

lower_co2 = fivenum_co2[2] 
higher_co2 = fivenum_co2[4]

summary_co2  = tibble(min= min_co2, lower_hinge = lower_co2, 
                      median =median_co2, higher_hinge = higher_co2,
                      max = max_co2) 

summary_co2 %>% write_tsv("results/co2_summary.tsv")


# create histogram of co2 per capita for year/country combination
p = co2_data %>%
  ggplot(aes(x = co2_per_capita)) + 
  geom_histogram() +
  geom_vline(xintercept = median_co2,
             linetype = "dashed") +
  labs(x = "CO2 emission per capita (tonnes)", 
       y = "Number of country_year") +
  theme_bw()
p
# save the histogram
ggsave(filename = "results/response-histogram.png", 
       plot = p, 
       device = "png", 
       width = 5, 
       height = 3)

# examine top 20 counties/year by co2 per capita
top_co2 = co2_data %>% 
  select(country, year, co2_per_capita) %>%
  arrange(desc(co2_per_capita)) %>%
  head(20) 

top_co2
top_co2%>% write_tsv("results/top-20-co2-data.tsv")

# examine average co2 per capita for different countries 
co2_country = co2_data  %>%  group_by(country) %>%
  summarise(mean_co2 = mean(co2_per_capita)) %>% 
  arrange(desc(mean_co2))

co2_country

# create histogram of mean_co2 for different countries
p2 = co2_country %>%
  ggplot(aes(x = mean_co2)) + 
  geom_histogram() +
  geom_vline(xintercept = median(co2_country$mean_co2),
             linetype = "dashed") +
  labs(x = "Mean CO2 emission per capita (tonnes)", 
       y = "Number of countries") +
  theme_bw()
p2
# save the histogram
ggsave(filename = "results/response-histogram-co2_mean_country.png", 
       plot = p2, 
       device = "png", 
       width = 5, 
       height = 3)

# for top 20 country with highest average co2, examine their change of co2 per 
# capita over time using scatter plot
temp = co2_country %>% head(20)              

temp2 = co2_data%>% filter(country %in%  temp$country) %>%
  arrange(desc(co2_per_capita))


p3 = temp2%>% ggplot() +                       # create an empty ggplot
  geom_point(mapping =             # add scatter plot
               aes(x = year,      # x axis location of points
                   y = co2_per_capita)) +
  facet_wrap(~ country) + theme_bw()

p3

# save the scatter plot
ggsave(filename = "results/response-histogram-co2_country_over_year.png", 
       plot = p3, 
       device = "png", 
       width = 10, 
       height = 6)

# plot each feature against co2_per_capita using scatter plot

temp3 = co2_data%>% 
  pivot_longer(!c(country_year, iso_code, country, 
                  year, co2_per_capita), names_to = "var", 
               values_to = "value")%>% 
  select(var, value, co2_per_capita)

p4 = temp3%>% ggplot() +                       # create an empty ggplot
  geom_point(mapping =             # add scatter plot
               aes(x = value,      # x axis location of points
                   y = co2_per_capita)) +
  facet_wrap(~var, scales = "free", nrow = 5) + theme_bw()

p4
# save the scatter plot
ggsave(filename = "results/response-histogram-co2_vs_feature.png", 
       plot = p4, 
       device = "png", 
       width = 18, 
       height = 13)

