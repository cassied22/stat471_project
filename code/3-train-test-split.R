# read in the cleaned data
co2_data = read_csv("data/clean/co2_data.csv")


co2_data%>% filter(year >=2012)
# split into train and test (set seed here if applicable)
# set the instances with year <= 2012 as training set and 
# the remaining as testing test

co2_train= co2_data %>% filter(year <2012)
co2_train
co2_test = co2_data %>% filter(year >= 2012)

# save the train and test data
write_tsv(x = co2_train, file = "data/clean/co2_train.tsv")
write_tsv(x = co2_test, file = "data/clean/co2_test.tsv")
