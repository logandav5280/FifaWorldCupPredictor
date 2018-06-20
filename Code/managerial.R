library(dplyr)
library(rvest)
library(stringr)

URL1 = "https://en.wikipedia.org/wiki/List_of_South_American_national_football_team_managers"
URL2 = "https://en.wikipedia.org/wiki/List_of_European_national_football_team_managers"
URL3 = "https://en.wikipedia.org/wiki/List_of_African_national_football_team_managers"
#Africa
t <- read_html(URL3) %>% html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 1) and parent::*)]') %>% html_text()
t <- t[-58]
t1 <- read_html(URL3) %>% html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 4) and parent::*)]') %>% html_text()
a_country <- data.frame(Country = t, Tenure = t1)

#Europe
t <- read_html(URL2) %>% html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 1) and parent::*)]') %>% html_text()
t <- t[-56]
t1 <- read_html(URL2) %>% html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 4) and parent::*)]') %>% html_text()
e_country <- data.frame(Country = t, Tenure = t1)

#South America
t <- read_html(URL1) %>% html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 1) and parent::*)]') %>% html_text()
t <- t[-14]
t1 <- read_html(URL1) %>% html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 4) and parent::*)]') %>% html_text()
sa_country <- data.frame(Country = t, Tenure = t1)
a_e
a_e_sa <- rbind(a_country, e_country, sa_country)
a_e_sa$Tenure <- gsub(".*♠","",a_e_sa$Tenure)
gsub(".*♠","",m)
saveRDS(a_e_sa,file = "managers~.RDS")
a_e_sa$Tenure %>% str_replace(".*_", "_")
a_e_sa
