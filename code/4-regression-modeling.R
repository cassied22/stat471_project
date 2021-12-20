# load libraries
library(glmnetUtils)                    # to run ridge and lasso
source("code/functions/plot_glmnet.R")            # for lasso/ridge trace plots

# read in the training data
co2_train = read_tsv("data/clean/co2_train.tsv")
co2_train
# run ridge regression
set.seed(1)
ridge_fit = cv.glmnet(co2_per_capita ~ . - country_year - iso_code - country - year,   
                      alpha = 0,                 
                      nfolds = 10,               
                      data = co2_train)

# save the ridge fit object
save(ridge_fit, file = "results/ridge_fit.Rda")

# create ridge CV plot
png(width = 6, 
    height = 4,
    res = 300,
    units = "in", 
    filename = "results/ridge-cv-plot.png")
plot(ridge_fit)
dev.off()

# create ridge trace plot
p2 = plot_glmnet(ridge_fit, co2_train, features_to_plot = 6)
ggsave(filename = "results/ridge-trace-plot.png", 
       plot = p2, 
       device = "png", 
       width = 6, 
       height = 4)
p2

# extract features coefficients
beta_hat_std_ridge = extract_std_coefs(ridge_fit, co2_train)
beta_hat_std_ridge %>%
  arrange(desc(abs(coefficient))) %>% 
  write_tsv("results/ridge-features-table.tsv")



# run lasso regression
set.seed(1)
lasso_fit = cv.glmnet(co2_per_capita ~ . - country_year - iso_code - country - year,   
                      alpha = 1,                 
                      nfolds = 10,               
                      data = co2_train)

# save the lasso fit object
save(lasso_fit, file = "results/lasso_fit.Rda")

# create lasso CV plot
png(width = 6, 
    height = 4,
    res = 300,
    units = "in", 
    filename = "results/lasso-cv-plot.png")
plot(lasso_fit)
dev.off()

# create lasso trace plot
p = plot_glmnet(lasso_fit, co2_train, features_to_plot = 6)
ggsave(filename = "results/lasso-trace-plot.png", 
       plot = p, 
       device = "png", 
       width = 6, 
       height = 4)
p
# extract features selected by lasso and their coefficients
beta_hat_std = extract_std_coefs(lasso_fit, co2_train)
beta_hat_std %>%
  filter(coefficient != 0) %>%
  arrange(desc(abs(coefficient))) %>% 
  write_tsv("results/lasso-features-table.tsv")


