############
library(dplyr)
library(rvest)
df <- read.csv("https://query.data.world/s/jafelh2x5omnrqnv3wd56srenw77yq", header=TRUE, stringsAsFactors=FALSE);
df <- df %>% mutate(popularity = tv_audience_share / population_share)
df[1:2] <- lapply(df[1:2], tolower)
df$country <- gsub('\\s+', '', df$country)
head(df)
write.csv(df, file = "generalinfo.csv", sep = ",", row.names = FALSE, col.names = TRUE)
################

