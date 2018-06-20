library(data.table)
library(tictoc)
dt <- fread(file = "results.csv")
head(dt)
#2018 world cup countries
wc_countries <- c("Argentina","Australia","Belgium","Brazil","Colombia","Costa Rica","Croatia","Denmark","Egypt","England","France","Germany","Iceland","Iran","Japan","Korea Republic","Mexico","Morocco","Nigeria","Panama","Peru","Poland","Portugal","Russia","Saudi Arabia","Senegal","Serbia","Spain","Sweden","Switzerland","Tunisia","Uruguay")
#empty temp vectors
vec <- c()
won <- c()
diff<- c()
#calcuting name of winner, goal difference and winning column
for(i in 1:nrow(dt)){
  if (dt[['home_score']][i] > dt[['away_score']][i]){
    vec <- c(vec, dt[['home_team']][i])
    won <- c(won,1)
  } else if (dt[['home_score']][i] < dt[['away_score']][i]){
    vec <- c(vec, dt[['away_team']][i])
    won <- c(won,2)
  } else {
    vec <- c(vec, "Draw")
    won <- c(won,0)
  }
  diff <- c(diff, abs(dt[['home_score']][i] - dt[['away_score']][i]))
}
#adding vecotrs to columns
dt[['winner']] <- vec
dt[['goal_diff']] <- diff      
dt[['winning_team']] <- won
#keeping only year in the date
dt[['date']] <- substr(dt[['date']], start = 1, stop = 4)
#extracting world cup countries from data table
temp <- dt[ which(dt[['home_team']] %in% wc_countries & dt[['away_team']] %in% wc_countries) , ]

dt <- readRDS("Data/h2hforwc.RDS")

#checking for duplicate values
dt[duplicated(dt[['home_team','away_team']]),]
dt[, c("home_score","away_score","city", "country", "neutral"):=NULL]
#finding distinct tournament types
unique(temo[['tournament']])
#removing all entries before 1930
dt <- dt[!(dt[['date']] %in% 1874:1929),]
#dt <- dt[(dt[['tournament']] ==),]
#calculating tournament freq
tournament_freq <- as.data.frame(table(dt[['tournament']]))
#removing any tournaments which have freq <10
unnec_torunaments <- tournament_freq$Var1[tournament_freq$Freq < 10]
dt <- dt[!(dt[['tournament']] %in% unnec_torunaments),]

saveRDS(dt, "only_valid_tournies_after_1930.RDS")
