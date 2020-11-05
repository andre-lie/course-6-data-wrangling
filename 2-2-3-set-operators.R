library(tidyverse)
library(dslabs)
tab <- left_join(murders,results_us_election_2016, by="state")

# intersect vectors or data frames
intersect(1:10,6:15)
intersect(c("a","b","c"),c("b","c","d"))
tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
intersect(tab1,tab2)

# perform a union of vectors or data frames
union(1:10,6:15)
union(c("a","b","c"),c("b","c","d"))
tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
union(tab1,tab2)

# set difference of vectors or data frames
setdiff(1:10,6:15)
setdiff(6:15,1:10)
tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
setdiff(tab1,tab2)

# setequal determines whether sets have the same elements, regardless of order
setequal(1:5,1:6)
setequal(1:5,5:1)
setequal(tab1,tab2)
