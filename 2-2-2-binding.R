library(tidyverse)
library(dslabs)
tab <- left_join(murders,results_us_election_2016, by="state")

bind_cols(a=1:3,b=4:6)

tab1 <- tab[,1:3]
tab2 <- tab[,4:6]
tab3 <- tab[,7:9]
new_tab <- bind_cols(tab1,tab2,tab3)
head(new_tab)

tab1 <- tab[1:2,]
tab2 <- tab[3:4,]
bind_rows(tab1,tab2)
