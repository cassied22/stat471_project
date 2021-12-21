# load libraries
library(randomForest)       # install.packages("randomForest")
library(tidyverse)
library(gbm)


# read in the training data
co2_train = read_tsv("data/clean/co2_train.tsv")
co2_train

# run random forest 
set.seed(1)

rf_fit = randomForest(co2_per_capita ~ . - country_year - iso_code - country - year,   
                      importance = TRUE,data = co2_train)

# save the random forest fit object
save(rf_fit, file = "results/rf_fit.Rda")

# create random forest error plot
png(width = 6, 
    height = 4,
    res = 300,
    units = "in", 
    filename = "results/rf-error-plot.png")
plot(rf_fit)
dev.off()

# create rf importance plot
png(width = 8, 
    height = 5,
    res = 300,
    units = "in", 
    filename = "results/rf-importance-plot.png")
varImpPlot(rf_fit)
dev.off()


# run boosting 
set.seed(1)

gbm_fit = gbm(co2_per_capita ~ . - country_year - iso_code - country - year,   
                       distribution = "gaussian",
                       n.trees = 200,
                       interaction.depth = 1,
                       shrinkage = 0.1,
                       cv.folds = 5,,data = co2_train)

# save the boosting fit object
save(gbm_fit, file = "results/gbm_fit.Rda")

# create boosting CV plot
png(width = 6, 
    height = 4,
    res = 300,
    units = "in", 
    filename = "results/gbm-cv-plot.png")
gbm.perf(gbm_fit)
dev.off()

# create boosting importance plot
png(width = 8, 
    height = 5,
    res = 300,
    units = "in", 
    filename = "results/rf-importance-plot.png")
varImpPlot(rf_fit)
dev.off()


feature_importance_gbm = tibble(summary(gbm_fit, n.trees = 200, plotit = FALSE))
feature_importance_gbm %>% 
  write_tsv("results/gbm-features-importance-table.tsv")

p = feature_importance_gbm%>% ggplot(aes(x = var, y = rel.inf)) + 
  geom_bar(stat="identity") +
  labs(x = "feature", 
       y = "relative importance") +
  theme_bw()
p
ggsave(filename = "results/gbm-relative-importance-plot.png", 
       plot = p, 
       device = "png", 
       width = 18, 
       height = 6)
