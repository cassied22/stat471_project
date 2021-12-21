# load libraries
library(glmnetUtils)
library(tidyverse)

# load test data
co2_test = read_tsv("data/clean/co2_test.tsv")

# load ridge fit object
load("results/ridge_fit.Rda")

# load lasso fit object
load("results/lasso_fit.Rda")

# load elastic net fit object
load("results/en_fit.Rda")

# load random forest fit object
load("results/rf_fit.Rda")

# load boosting fit object
load("results/gbm_fit.Rda")

# evaluate ridge RMSE
ridge_predictions = predict(ridge_fit, 
                            newdata = co2_test, 
                            s = "lambda.1se") %>%
  as.numeric()
ridge_RMSE = sqrt(mean((ridge_predictions-co2_test$co2_per_capita)^2))
ridge_RMSE

# evaluate lasso RMSE
lasso_predictions = predict(lasso_fit, 
                            newdata = co2_test, 
                            s = "lambda.1se") %>%
  as.numeric()
lasso_RMSE = sqrt(mean((lasso_predictions-co2_test$co2_per_capita)^2))
lasso_RMSE

# evaluate elastic net RMSE
en_predictions = predict(en_fit, 
                            newdata = co2_test, 
                            s = "lambda.1se") %>%
  as.numeric()
en_RMSE = sqrt(mean((en_predictions-co2_test$co2_per_capita)^2))
en_RMSE

# evaluate random forest RMSE
rf_predictions = predict(rf_fit, newdata = co2_test) 
rf_RMSE = sqrt(mean((rf_predictions-co2_test$co2_per_capita)^2))
rf_RMSE

# evaluate boosting RMSE
gbm_predictions = predict(gbm_fit,n.trees =200, newdata = co2_test)

gbm_RMSE = sqrt(mean((gbm_predictions-co2_test$co2_per_capita)^2))
gbm_RMSE

# print nice table
rmse = tibble(Method = c("Ridge", "Lasso","Elastic Net", "Random Forest", "Boosting"), 
       `Test RMSE` = c(ridge_RMSE, lasso_RMSE, en_RMSE, rf_RMSE, gbm_RMSE))
rmse%>%
  write_tsv("results/model-evaluation.tsv")
